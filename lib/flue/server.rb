require "fileutils"
require "rack"

module Flue
  class Server
    attr_reader :renderer, :watcher

    def initialize(renderer)
      @renderer = renderer
      @watcher = Watcher.new(@renderer.files)
    end

    def start(options={})
      app = Rack::Builder.new
      app.use Flue::Middleware, watcher, renderer
      app.run Rack::Directory.new(File.join([Dir.pwd, "_site"]))
      Rack::Server.start :app => app, :Port => (options[:port] || 3000), :server => options[:type]
    end

  end
end
