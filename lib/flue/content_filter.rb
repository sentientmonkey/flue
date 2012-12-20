require "erb"
require "fileutils"
require "maruku"
require "redcloth"
require "gemoji"
require "sass"
require "coffee-script"
require "nokogiri"
require "coderay"

module Flue
  class MarkdownFilter
    def call(input, options={})
      maruku = Maruku.new(input)
      if options[:partial]
        maruku.to_html
      else
        maruku.to_html_document
      end
    end
  end

  class TextileFilter
    def call(input, options={})
      RedCloth.new(input).to_html
    end
  end

  class ERBFilter
    include Flue::Logger
    include Flue::Benchmark

    def call(input, options={})
      if options[:variables]
        options[:variables].each do |name,value|
          instance_variable_set("@#{name.to_s}", value)
        end
      end
      ERB.new(input).result(binding)
    end

    def partial(name)
      partialfile = PartialFile.new(name)
      benchmark "#{partialfile.basename} => partial" do
        call( FilterRegister.run(partialfile.exts, partialfile.content, :partial => true) )
      end
    end
  end

  class EmojiFilter
    def call(input, options={})
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

  class CodeFilter
    def call(input, options={})
      doc = Nokogiri::HTML::DocumentFragment.parse(input)
      doc.css('code').each do |code|
        language = code["data-language"] || "ruby"
        code.replace(CodeRay.scan(code.content, language.to_sym).div)
      end
      doc.to_html
    end
  end

  class SassFilter
    def call(input, options={})
      if options[:variables]
        variable_input = options[:variables].map do |name,value|
          "$#{name}: #{value};"
        end.join(' ')
        input = [variable_input, input].join(' ')
      end
      engine = Sass::Engine.new(input, :syntax => :scss)
      engine.render
    end
  end

  class CoffeeScriptFilter
    def call(input, options={})
      CoffeeScript.compile(input)
    end
  end
end
