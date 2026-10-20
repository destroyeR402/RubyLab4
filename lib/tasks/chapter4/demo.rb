require "prism"
require "stringio"

# Runs a chapter 4 example file statement by statement and annotates each one
# with its result, in the "xmpfilter" style:
#
#   "foo" + "bar"
#   # => "foobar"
#   puts "foo"
#   # >> foo
#   # => nil
#
# Statements are split with Prism (Ruby's parser), evaluated at the top level
# just like in `rails console`, and anything they print is captured and shown
# after "# >>". Exceptions the manual demonstrates are shown after "# !!".
module Chapter4Demo
  module_function

  def run(path)
    # Prism reports byte offsets, so the source is sliced as bytes.
    source = File.binread(path)
    statements = Prism.parse(source.dup.force_encoding(Encoding::UTF_8)).value.statements.body
    cursor = 0

    statements.each do |node|
      start  = node.location.start_offset
      finish = node.location.end_offset

      print_comments(utf8(source.byteslice(cursor...start)))
      code, cursor = with_trailing_comment(source, node.slice, finish)

      if heading?(node)
        puts "", "## #{TOPLEVEL_BINDING.eval(node.arguments.slice)}", ""
      else
        puts code
        evaluate(node.slice)
      end
    end
    puts
  end

  # `section "4.2.2 Strings"` lines in the example files become headings.
  def heading?(node)
    node.is_a?(Prism::CallNode) && node.name == :section && node.receiver.nil?
  end

  def utf8(bytes)
    bytes.force_encoding(Encoding::UTF_8)
  end

  def print_comments(gap)
    gap.each_line { |line| puts line.strip if line.strip.start_with?("#") }
  end

  # Keeps a comment written on the same line after the statement.
  def with_trailing_comment(source, code, finish)
    line_end = source.index("\n", finish) || source.length
    rest = utf8(source.byteslice(finish...line_end))
    rest.strip.start_with?("#") ? ["#{code}#{rest}", line_end] : [code, finish]
  end

  def evaluate(code)
    output = StringIO.new
    original, $stdout = $stdout, output
    result = TOPLEVEL_BINDING.eval(code, "(chapter4)")
    $stdout = original
    show_output(output.string)
    puts "# => #{result.inspect}"
  rescue ScriptError, StandardError => e
    $stdout = original
    show_output(output.string)
    puts "# !! #{e.class}: #{e.message.lines.first.chomp}"
  end

  def show_output(text)
    return if text.empty?
    text = text.end_with?("\n") ? text : "#{text}\n"
    text.each_line { |line| puts "# >> #{line.chomp}" }
  end
end
