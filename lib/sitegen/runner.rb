require "fileutils"
require "yaml"

module Sitegen
  class Runner
    include Sitegen::Benchmark

    def files
      Dir["site/[^_]*"] - Dir["site/*.yml"]
    end

    def run
      puts "beginning run..."
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
