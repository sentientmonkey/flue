require "coffee-script"

module Flue
  class CoffeeScriptFilter
    def call(input, options={})
      if options[:variables]
        variable_input = options[:variables].map do |name,value|
          "#{name} = #{value}"
        end.join("\n")
        input = [variable_input, input].join("\n")
      end
      CoffeeScript.compile(input)
    end
  end
end
