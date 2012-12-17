module Flue
  class FilterRegister
    @@filters = {}

    def self.filters
      @@filters
    end

    def self.register(ext, filter)
      filters[ext.to_s] = filter
    end

    def self.run(exts, content, options={})
      f = exts.pop
      return content unless f
      result = run_ext(f, content, options)
      run(exts,result, options)
    end

    def self.run_ext(ext,content, options)
      if filters[ext]
        filters[ext].new.call(content, options)
      else
        content
      end
    end
  end
end
