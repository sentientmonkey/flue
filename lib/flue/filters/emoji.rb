require "gemoji"
require "fileutils"

module Flue
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
end
