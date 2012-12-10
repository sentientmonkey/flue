require "fileutils"
require "benchmark"

module Sitegen
  class Runner
    def files
      Dir["site/[^_]*"]
    end

    def benchmark(label)
      ms = Benchmark.realtime do
        yield
      end
      puts "#{label} (#{ms})"
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
