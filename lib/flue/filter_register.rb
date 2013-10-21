module Flue
  class FilterRegister

    def self.filters
      @@filters ||= {}
    end

    def self.clear
      @@filters = {}
    end

    def self.filters_by_name
      filters.each_with_object({}) do |(ext,filter_array),ret|
        filter_array.each do |filter|
          ret[filter] ||= []
          ret[filter] << ext
        end
      end
    end

    def self.register(ext, filter)
      ext_name = ext.to_s
      filters[ext_name] ||= []
      filters[ext_name] << filter
    end

    def self.run(exts, content, options={})
      filter = exts.pop
      return content unless filter
      result = run_ext(filter, content, options)
      run(exts,result, options)
    end

    def self.run_ext(ext, content, options)
      if filters[ext]
        filters[ext].inject(content) do |cont, filter|
          filter.new.call(cont, options)
        end
      else
        content
      end
    end
  end
end
