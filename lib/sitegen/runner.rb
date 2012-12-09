require "fileutils"

module Sitegen
  class Runner
    def files
      Dir["site/*"]
    end

    def run
      puts "beginning run..."
      files.each do |file|
        basefile = Basefile.new(file)
        File.open(basefile.outfile_name, "w") do |f|
          puts "#{basefile.basename} => #{basefile.outfile_name}"
          f.write FilterRegister.run(basefile.exts, basefile.content)
        end
      end
    end
  end
end
