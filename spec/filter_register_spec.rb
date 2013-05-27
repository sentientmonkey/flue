require "./spec/test_helper.rb"

describe FilterRegister do
  class MockFilter
    def call(input,options={})
      "mock"
    end
  end

  class MockOtherFilter
    def call(input,options={})
      input + "other"
    end
  end

  before do
    FilterRegister.clear
  end

  it "should run registered filters" do
    FilterRegister.register :mock, MockFilter
    FilterRegister.run(["mock"], "test").must_equal "mock"
  end

  it "should echo unregistered filters" do
    FilterRegister.run(["notavailable"], "test").must_equal "test"
  end

  it "should run multiple filters for different extensions" do
    FilterRegister.register :mock, MockFilter
    FilterRegister.register :mockother, MockOtherFilter
    FilterRegister.run(["mockother", "mock"], "test").must_equal "mockother"
  end

  it "should multiple filters for the same extension" do
    FilterRegister.register :mock, MockFilter
    FilterRegister.register :mock, MockOtherFilter
    FilterRegister.run(["mock"], "test").must_equal "mockother"
  end

  it "should fetch filters by name" do
    FilterRegister.register :mock, MockFilter
    FilterRegister.register :mockother, MockOtherFilter
    filters_by_name = {MockFilter => ["mock"], MockOtherFilter => ["mockother"]}
    FilterRegister.filters_by_name.must_equal filters_by_name
  end
end
