require 'fileutils'
require 'yaml'

module Flue
  class Renderer
    include Flue::Benchmark
    include Flue::Logger

    def files
      Dir["site/[^_]*"] - Dir["site/*.yml"]
    end

    def render_files
      files.each do |file|
        render_file file
      end
    end

    def render_file(file)
      basefile = Basefile.new(file)
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
    end

  end
end
