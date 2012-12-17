require "benchmark"

module Sitegen
  module Benchmark
    def benchmark(label)
      result = nil
      ms = ::Benchmark.realtime do
        result = yield
      end
      if logger
        logger.info "#{label} (#{ms})"
      end
      result
    end
  end
end
