require "fileutils"
require "rack"
require 'ostruct'
require 'optparse'

module Flue
  class Runner
    include Flue::Benchmark
    include Flue::Logger

    attr_reader :renderer

    def initialize
      @renderer = Renderer.new
    end

    def parse(args)
      options = OpenStruct.new

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: flue [options]"

        opts.separator ""
        opts.separator "Specific options:"

        opts.on_tail("-s", "--server", "run in server mode") do
          options.run_server = true
        end
        opts.on_tail("-h", "--help", "shows this message") do
          puts opts
          exit
        end
      end

      opts.parse!(args)
      options
    end

    def run(args)
      options = parse(args)
      logger.info "beginning run..."
      renderer.render_files
      if options.run_server
        server
      end
    end

    def server
      watcher = Watcher.new(renderer.files)
      r = renderer
      app = Rack::Builder.new do
        use Flue::Middleware, watcher, r
        run Rack::Directory.new(File.join([Dir.pwd, "_site"]))
      end
      Rack::Server.start :app => app, :Port => 9292
    end

  end
end
