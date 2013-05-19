require './spec/test_helper.rb'

describe Renderer do

  RENDER_FILE = 'a.erb.html'
  RENDERED_FILE = 'a.html'
  YAML_FILE = 'a.yml'
  FILE_lIST = [RENDER_FILE, YAML_FILE]
  YAML_LIST = [YAML_FILE]
  RESULT_LIST = [RENDER_FILE]

  class DirMock
    def call(glob)
      case glob
      when "site/[^_]*"
        FILE_lIST
      when "site/*.yml"
        YAML_LIST
      end
    end
  end

  class FileMock
    def call(filename, writemode)
      filename.must_equal RENDERED_FILE
      writemode.must_equal "w"
      #TODO figure out to verify a block
    end
  end

  let(:renderer) do
    Renderer.new
  end

  let(:basefile) do
    b = MiniTest::Mock.new
    b.expect :outfile_name, RENDERED_FILE
    b
  end

  it "should fetch files" do
    Dir.stub :[], DirMock.new do
      renderer.files.must_equal RESULT_LIST
    end
  end

  it "should render a file" do
    File.stub :open, FileMock.new do
      Basefile.stub :new, basefile do
        renderer.render_file RENDER_FILE
      end
    end
  end

  it "should render files"

end
