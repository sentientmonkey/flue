module Sitegen
  class FilterRegister
    @@filters = {}

    def self.filters
      @@filters
    end

    def self.register(ext, filter)
      filters[ext.to_s] = filter
    end

    def self.run(exts, content)
      f = exts.pop
      return content unless f
      result = run_ext(f, content)
      run(exts,result)
    end

    def self.run_ext(ext,content)
      if filters[ext]
        filters[ext].new.call(content)
      else
        content
      end
    end
  end
end
