require 'flue/filters/markdown.rb'
require 'flue/filters/erb.rb'
require 'flue/filters/textile.rb'
require 'flue/filters/emoji.rb'
require 'flue/filters/code.rb'
require 'flue/filters/sass.rb'
require 'flue/filters/coffee_script.rb'

module Flue

  FilterRegister.register :erb, ERBFilter
  FilterRegister.register :md, MarkdownFilter
  FilterRegister.register :textile, TextileFilter
  FilterRegister.register :emoji, EmojiFilter
  FilterRegister.register :code, CodeFilter
  FilterRegister.register :html, CodeFilter
  FilterRegister.register :html, EmojiFilter
  FilterRegister.register :scss, SassFilter
  FilterRegister.register :coffee, CoffeeScriptFilter

end
