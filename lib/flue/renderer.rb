require 'fileutils'
require 'yaml'

module Flue
  class Renderer
    include Flue::Benchmark
    include Flue::Logger

    attr_reader :metadata

    def initialize
      @metadata = Metadata.new
    end

    def files
      Dir["site/[^_]*"] - Dir["site/*.yml"]
    end

    def basefiles
      files.map do |file|
        Basefile.new(file)
      end
    end

    def render_files
      basefiles.each do |basefile|
        render_file basefile
      end
    end

    def render_file(basefile)
      File.open(basefile.outfile_name, "w") do |f|
        benchmark "#{basefile.basename} => #{basefile.outfile_name}" do
          options = {}
          data = basefile.datafile
          if data
            options[:variables] = YAML.load(data)
          end
          f.write FilterRegister.run(basefile.exts, basefile.content, options)
        end
      end
      metadata.update_checksum(basefile)
    end

  end
end
