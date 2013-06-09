require "fileutils"
require "digest/sha2"

module Flue
  class Basefile
    attr_reader :filename, :options

    def initialize(filename, options={})
      @filename = filename
      @options = options
    end

    def parts
      basename.split(".")
    end

    def dirname
      File.dirname filename
    end

    def basename
      File.basename filename
    end

    def exts
      [parts[-1], *parts[1..-2]]
    end

    def outfile_basename
      [parts[0], parts[-1]].join(".")
    end

    def outfile_name
      ["_site", outfile_basename].join("/")
    end

    def datafile_basename
      [parts[0], "yml"].join(".")
    end

    def datafile_name
      [dirname, datafile_basename].join("/")
    end

    def datafile
      if File.exists? datafile_name
        File.read(datafile_name)
      end
    end

    def content
      File.read(filename)
    end

    def checksum
      digest.hexdigest(content)
    end

    def ==(other)
      other.class == self.class &&
        other.filename == self.filename &&
        other.checksum == self.checksum
    end
    alias_method :eql?, :==

    private

    def digest
      Digest::SHA256
    end
  end
end
