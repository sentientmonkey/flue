require "sitegen/version"
require "erb"
require "fileutils"
require "maruku"
require "redcloth"
require "gemoji"
require "sass"

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
      parts[1..-2]
    end

    def outfile_basename
      [parts[0], parts[-1]].join(".")
    end

    def outfile_name
      ["_site", outfile_basename].join("/")
    end

    def content
      File.read(filename)
    end
  end

  class ContentFilter
    def self.filter(input)
      input
    end
  end

  class MarkdownFilter < ContentFilter
    def self.filter(input)
      Maruku.new(input).to_html_document
    end
  end

  class TextileFilter < ContentFilter
    def self.filter(input)
      RedCloth.new(input).to_html
    end
  end

  class ERBFilter < ContentFilter
    def self.filter(input)
      ERB.new(input).result(binding)
    end
  end

  class EmojiFilter < ContentFilter
    def self.filter(input)
     input.gsub(/:([a-z0-9\+\-_]+):/) do |match|
        if Emoji.names.include?($1)
          FileUtils.mkdir_p "_site/images/emoji"
          FileUtils.cp "#{Emoji.images_path}/emoji/#{$1}.png", "_site/images/emoji/#{$1}.png"
          '<img alt="' + $1 + '" height="20" src="images/' + "emoji/#{$1}.png" + '" style="vertical-align:middle" width="20" />'
        else
          match
        end
      end
    end
  end

  class SassFilter < ContentFilter
    def self.filter(input)
      engine = Sass::Engine.new(input, :syntax => :scss)
      engine.render
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
  FilterRegister.register :textile, TextileFilter
  FilterRegister.register :emoji, EmojiFilter
  FilterRegister.register :sass, SassFilter

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
