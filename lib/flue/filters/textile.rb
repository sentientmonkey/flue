require "redcloth"

module Flue
  class TextileFilter
    def call(input, options={})
      RedCloth.new(input).to_html
    end
  end
end
