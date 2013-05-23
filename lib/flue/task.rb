require 'thor'

module Flue
  class Task < Thor
    desc "build", "builds site"
    def build
      @renderer = Renderer.new
      @renderer.render_files
    end

    desc "server [options]", "runs server mode"
    method_option :type, :aliases => "-t", :desc => "Type of server"
    def server
      build
      server = Server.new(@renderer)
      server.start(options)
    end
  end
end
