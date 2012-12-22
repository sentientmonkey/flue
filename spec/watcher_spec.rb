require './spec/test_helper.rb'

describe Watcher do
  let(:watcher) do
    Watcher.new ["a", "b"]
  end

  let(:now) do
    Time.now.to_i
  end

  let(:later) do
    now + 1000
  end

  it "should find mtimes" do
    File.stub :mtime, now do
      watcher.mtimes.must_equal({"a" => now, "b" => now})
    end
  end

  it "should find changes" do
    File.stub :mtime, now do
      watcher.mtimes
      watcher.changes.must_equal({})
    end
    File.stub :mtime, later do
      watcher.changes.must_equal({"a" => later, "b" => later})
    end
  end

  it "should call block when changed" do
    changed = nil
    change_files = Proc.new{|files| changed = files }
    File.stub :mtime, now do
      watcher.watch &change_files
    end
    changed.must_be_nil
    File.stub :mtime, later do
      watcher.watch &change_files
    end
    changed.must_equal ['a', 'b']
  end
end
