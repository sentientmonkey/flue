require "forwardable"

module Flue
  class PartialFile
    extend Forwardable
    attr_reader :name
    def_delegators :basefile, :basename, :exts, :content

    def initialize(name)
      @name = name
    end

    def partial_filename
      Dir[File.join(["site", "_#{name.to_s}"]) + "*"].first
    end

    def basefile
      Basefile.new(partial_filename, :partial => true)
    end
  end
end
