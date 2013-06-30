require 'fileutils'
require 'yaml'

module Flue
  class Renderer
    include Flue::Benchmark
    include Flue::Logger

    attr_reader :metadata, :filter_register, :dir, :basefile_class

    def initialize(metadata = Metadata.new, filter_register = FilterRegister, dir = Dir, basefile_class = Basefile)
      @metadata = metadata
      @filter_register = filter_register
      @dir = dir
      @basefile_class = basefile_class
    end

    def files
      dir["site/[^_]*"] - dir["site/*.yml"]
    end

    def basefiles
      files.map do |file|
        basefile_class.new(file)
      end
    end

    def render_files
      basefiles.each do |basefile|
        render_file basefile
      end
    end

    def render_file(basefile)
      open(basefile.outfile_name, "w") do |f|
        benchmark "#{basefile.basename} => #{basefile.outfile_name}" do
          options = {}
          data = basefile.datafile
          if data
            options[:variables] = YAML.load(data)
          end
          f.write filter_register.run(basefile.exts, basefile.content, options)
        end
      end
      metadata.update_checksum(basefile)
    end

  end
end
