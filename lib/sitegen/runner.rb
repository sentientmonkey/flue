require "fileutils"

module Sitegen
  class Runner
    include Sitegen::Benchmark

    def files
      Dir["site/[^_]*"]
    end

    def run
      puts "beginning run..."
      files.each do |file|
        basefile = Basefile.new(file)
        File.open(basefile.outfile_name, "w") do |f|
          benchmark "#{basefile.basename} => #{basefile.outfile_name}" do
            f.write FilterRegister.run(basefile.exts, basefile.content)
          end
        end
      end
    end
  end
end
