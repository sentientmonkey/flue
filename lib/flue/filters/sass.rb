require "sass"

module Flue
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
end
