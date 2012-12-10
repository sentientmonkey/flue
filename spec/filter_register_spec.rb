require "./spec/test_helper.rb"

describe FilterRegister do
  class MockFilter
    def call(input,options={})
      "mock"
    end
  end

  it "should run registered filters" do
    FilterRegister.register :mock, MockFilter
    FilterRegister.run(["mock"], "test").must_equal "mock"
  end

  it "should echo unregistered filters" do
    FilterRegister.run(["notavailable"], "test").must_equal "test"
  end
end
