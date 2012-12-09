module Sitegen

  FilterRegister.register :erb, ERBFilter
  FilterRegister.register :md, MarkdownFilter
  FilterRegister.register :textile, TextileFilter
  FilterRegister.register :emoji, EmojiFilter
  FilterRegister.register :code, CodeFilter
  FilterRegister.register :sass, SassFilter
  FilterRegister.register :coffee, CoffeeScriptFilter

end
