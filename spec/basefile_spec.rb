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

  it "should read basefile" do
    test_content = "test content"
    File.stub :read, test_content do
      md_erb.content.must_equal test_content
    end
  end

  it "should have a datafile_name" do
    md_erb.datafile_name.must_equal "site/test.yml"
  end

  it "should have a datafile_name" do
    test_data = "test data"
    File.stub :exists?, true do
      File.stub :read, test_data do
        md_erb.datafile.must_equal test_data
      end
    end
  end

  it "should not have test data when file does not exist" do
    File.stub :exists?, false do
      md_erb.datafile.must_equal nil
    end
  end

end

