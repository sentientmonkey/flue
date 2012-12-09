require "erb"
require "maruku"
require "redcloth"
require "gemoji"
require "sass"
require "coffee-script"
require "nokogiri"
require "coderay"

module Sitegen
  class MarkdownFilter
    def call(input)
      Maruku.new(input).to_html_document
    end
  end

  class TextileFilter
    def call(input)
      RedCloth.new(input).to_html
    end
  end

  class ERBFilter
    def call(input)
      ERB.new(input).result(binding)
    end
  end

  class EmojiFilter
    def call(input)
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
    def call(input)
      doc = Nokogiri::HTML::DocumentFragment.parse(input)
      doc.css('code').each do |code|
        language = code["data-language"] || "ruby"
        code.replace(CodeRay.scan(code.content, language.to_sym).div)
      end
      doc.to_html
    end
  end

  class SassFilter
    def call(input)
      engine = Sass::Engine.new(input, :syntax => :scss)
      engine.render
    end
  end

  class CoffeeScriptFilter
    def call(input)
      CoffeeScript.compile(input)
    end
  end
end
