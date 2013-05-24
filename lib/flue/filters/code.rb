require "nokogiri"
require "coderay"

module Flue
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
end
