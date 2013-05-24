require "./spec/test_helper.rb"

describe TextileFilter do
  it "should filter textile" do
    TextileFilter.new.call("h1. Just a test").must_equal "<h1>Just a test</h1>"
  end
end
