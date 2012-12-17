require "./spec/test_helper.rb"

describe Logger do
  class Foo
    include Sitegen::Logger
  end

  let(:custom_logger) do
    MiniTest::Mock.new
  end

  it "should be able to set a custom logger" do
    custom_logger.expect :info, true, ["test"]
    Foo.logger = custom_logger
    Foo.new.logger.info "test"
  end
end
