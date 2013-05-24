require "./spec/test_helper.rb"

describe SassFilter do
  it "should filter sass" do
    SassFilter.new.call("table.h1{ td.ln { font: { color: red; } } }").must_equal "table.h1 td.ln {\n  font-color: red; }\n"
  end

  it "should filer sass with variables" do
    SassFilter.new.call("table.h1{ td.ln { font: { color: $tablecolor; } } }", :variables => {:tablecolor => 'red'}).must_equal "table.h1 td.ln {\n  font-color: red; }\n"
  end
end
