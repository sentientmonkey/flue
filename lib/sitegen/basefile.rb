require "fileutils"

module Sitegen
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
      parts[1..-2]
    end

    def outfile_basename
      [parts[0], parts[-1]].join(".")
    end

    def outfile_name
      ["_site", outfile_basename].join("/")
    end

    def content
      File.read(filename)
    end
  end
end
