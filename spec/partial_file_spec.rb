require "./spec/test_helper.rb"

describe PartialFile do
  let(:partial) do
    PartialFile.new("site/_test.md.erb.html")
  end

  it "should have basefile" do
    partial.basefile.must_be_instance_of Basefile
  end

end
