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
      #HACK need to assign locals for scoping
      w = watcher
      r = renderer
      app = Rack::Builder.new do
        use Flue::Middleware, w, r
        run Rack::Directory.new(File.join([Dir.pwd, "_site"]))
      end
      Rack::Server.start :app => app, :Port => 9292, :server => options[:type]
    end

  end
end
