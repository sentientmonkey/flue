require "benchmark"

module Sitegen
  module Benchmark
    def benchmark(label)
      result = nil
      ms = ::Benchmark.realtime do
        result = yield
      end
      puts "#{label} (#{ms})"
      result
    end
  end
end
