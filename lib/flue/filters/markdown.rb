require "maruku"

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
end
