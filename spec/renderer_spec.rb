require './spec/test_helper.rb'
require 'ostruct'

describe Renderer do

  RENDER_FILE = 'a.erb.html'
  RENDERED_FILE = 'a.html'
  YAML_FILE = 'a.yml'
  FILE_lIST = [RENDER_FILE, YAML_FILE]
  YAML_LIST = [YAML_FILE]
  RESULT_LIST = [RENDER_FILE]
  RENDERED_RESULT = "result"

  class DirMock
    def self.[](glob)
      case glob
      when "site/[^_]*"
        FILE_lIST
      when "site/*.yml"
        YAML_LIST
      end
    end
  end

  module MockIO
    attr_reader :mock_io
    def open(*args)
      @mock_io = StringIO.new
      yield @mock_io
      @mock_io.close
    end
  end

  module MockBenchmark
    attr_reader :mock_benchmark_label
    def benchmark(*args)
      @mock_benchmark_label = args.first
      yield
    end
  end

  class MockFilterRegister
    def self.run(*args)
      RENDERED_RESULT
    end
  end

  class MockBasefile < OpenStruct
    def initialize(*args)
      super :basename => RENDER_FILE, :outfile_name => RENDERED_FILE, :datafile => ""
    end
  end

  let(:metadata){ MiniTest::Mock.new }

  let(:renderer) do
    r = Renderer.new(metadata, MockFilterRegister, DirMock, MockBasefile)
    r.extend MockIO
    r.extend MockBenchmark
    r
  end

  let(:basefile) do
    MockBasefile.new
  end

  let(:filter_result) do
    MiniTest::Mock.new
  end

  it "should fetch files" do
    renderer.files.must_equal RESULT_LIST
  end

  it "should fetch basefiles" do
    renderer.basefiles.must_equal [basefile]
  end

  it "should render a file" do
    metadata.expect(:update_checksum, true, [basefile])
    renderer.render_file basefile
    renderer.mock_io.string.must_equal RENDERED_RESULT
    renderer.mock_benchmark_label.must_equal "a.erb.html => a.html"
    metadata.verify
  end

  it "should render files" do
    metadata.expect(:update_checksum, true, [basefile])
    renderer.render_files
    renderer.mock_io.string.must_equal RENDERED_RESULT
    renderer.mock_benchmark_label.must_equal "a.erb.html => a.html"
    metadata.verify
  end
end
