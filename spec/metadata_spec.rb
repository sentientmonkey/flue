require "./spec/test_helper.rb"

describe Metadata do
  let(:filename){ "filename" }
  let(:checksum){ "checksum" }
  let(:basefile) do
    m = Minitest::Mock.new
    m.expect(:filename, filename)
    m.expect(:checksum, checksum)
    m
  end
  let(:basefiles){ [basefile] }
  let(:metadata){ Metadata.new }
  let(:store){ Minitest::Mock.new }

  it "must update checksum of files" do
    store.expect(:transaction, nil)
    #store.expect(:[]=, nil, ["checksums", {filename => checksum}])
    #TODO figure how to get block testing to work properly
    YAML::Store.stub :new, store do
      metadata.update_checksum(basefile)
    end
    store.verify
  end

end
