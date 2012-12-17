require "fileutils"
require "yaml"

module Flue
  class Runner
    include Flue::Benchmark
    include Flue::Logger

    def files
      Dir["site/[^_]*"] - Dir["site/*.yml"]
    end

    def run
      logger.info "beginning run..."
      files.each do |file|
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
end
