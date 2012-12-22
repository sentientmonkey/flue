module Flue
  class Watcher
    attr_reader :files, :last_mtimes

    def initialize(files)
      @files = files
      update_mtimes!
    end

    def update_mtimes!
      @last_mtimes = mtimes
    end

    def mtimes
      files.each_with_object({}) do |file,hash|
        hash[file] = File.mtime(file)
      end
    end

    def changed?
      !changes.empty?
    end

    def changes
      Hash[*(mtimes.to_a - last_mtimes.to_a).flatten]
    end

    def watch(&block)
      if changed?
        yield changes.keys
        update_mtimes!
      end
    end
  end
end
