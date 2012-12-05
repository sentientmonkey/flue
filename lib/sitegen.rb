require "sitegen/version"
require "erb"
require "maruku"

module Sitegen
  class Basefile
    attr_reader :filename

    def initialize(filename)
      @filename = filename
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
      parts[1..-1]
    end

    def outfile_basename
      [parts[0], "html"].join(".")
    end

    def outfile_name
      ["_site", outfile_basename].join("/")
    end

    def content
      File.read(filename)
    end
  end

  class MarkdownFilter
    def self.filter(input)
      Maruku.new(input).to_html
    end
  end

  class ERBFilter
    def self.filter(input)
      ERB.new(input).result(binding)
    end
  end

  class FilterRegister
    @@filters = {}

    def self.filters
      @@filters
    end

    def self.register(ext, filter)
      filters[ext.to_s] = filter
    end

    def self.run(exts, content)
      f = exts.pop
      return content unless f
      result = run_ext(f, content)
      run(exts,result)
    end

    def self.run_ext(ext,content)
      if filters[ext]
        filters[ext].filter(content)
      else
        content
      end
    end
  end

  FilterRegister.register :erb, ERBFilter
  FilterRegister.register :md, MarkdownFilter

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
