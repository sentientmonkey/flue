require "erb"

module Flue
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
end

