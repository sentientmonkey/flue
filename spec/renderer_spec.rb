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

  let(:metadata){ MiniTest::Mock.new }

  let(:filter_result) do
    MiniTest::Mock.new
  end

  it "should fetch files" do
    Dir.stub :[], DirMock.new do
      renderer.files.must_equal RESULT_LIST
    end
  end

  it "should fetch basefiles" do
    Dir.stub :[], DirMock.new do
      Basefile.stub :new, basefile do
        renderer.basefiles.must_equal [basefile]
      end
    end
  end

  it "should render a file" do
    metadata.expect(:update_checksum, true, [basefile])
    File.stub :open, FileMock.new do
      Basefile.stub :new, basefile do
        Metadata.stub :new, metadata do
          renderer.render_file basefile
        end
      end
    end
    metadata.verify
  end

  it "should render files" do
    metadata.expect(:update_checksum, true, [basefile])
    File.stub :open, FileMock.new do
      Dir.stub :[], DirMock.new do
        Basefile.stub :new, basefile do
          Metadata.stub :new, metadata do
            renderer.render_files
          end
        end
      end
    end
    metadata.verify
  end
end
