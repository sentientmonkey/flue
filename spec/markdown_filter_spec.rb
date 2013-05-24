require "./spec/test_helper.rb"

describe MarkdownFilter do
  it "should filter markdown" do
    MarkdownFilter.new.call("# Foo").must_equal (<<-eos
<?xml version=\"1.0\" encoding=\"utf-8\"?>
<!DOCTYPE html PUBLIC
    \"-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN\"
    \"http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd\">
<html xml:lang='en' xmlns:svg='http://www.w3.org/2000/svg' xmlns='http://www.w3.org/1999/xhtml'>
<head><meta content='application/xhtml+xml;charset=utf-8' http-equiv='Content-type' /><title>Foo</title></head>
<body>
<h1 id='foo'>Foo</h1>
</body></html>
eos
).chomp
  end

  it "should filter markdown partial" do
    MarkdownFilter.new.call("# Foo", :partial => true).must_equal "<h1 id='foo'>Foo</h1>"
  end
end
