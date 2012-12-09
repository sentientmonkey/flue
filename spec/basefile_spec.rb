require "./spec/test_helper.rb"

describe Basefile do
  let(:md_erb) do
    Basefile.new("site/test.md.erb.html")
  end

  it "should have basename" do
    md_erb.basename.must_equal "test.md.erb.html"
  end

  it "should have parts" do
    md_erb.parts.must_equal ["test","md","erb", "html"]
  end

  it "should have exts" do
    md_erb.exts.must_equal ["md","erb"]
  end

  it "should have dirname" do
    md_erb.dirname.must_equal "site"
  end

  it "should have outfile_basename" do
    md_erb.outfile_basename.must_equal "test.html"
  end

  it "should have outfile_name" do
    md_erb.outfile_name.must_equal "_site/test.html"
  end
end

