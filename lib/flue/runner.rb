require 'thor'

module Flue
  class Runner < Thor
    include Flue::Logger

    desc "build", "builds site"
    def build
      @renderer = Renderer.new
      @renderer.render_files
    end

    desc "server [options]", "runs server mode"
    method_option :type, :aliases => "-t", :desc => "Type of server"
    method_option :port, :aliases => "-p", :desc => "Port for server"
    def server
      build
      server = Server.new(@renderer)
      server.start(options)
    end

    desc "filters", "shows filters"
    def filters
      FilterRegister.filters_by_name.each do |filter,ext|
        logger.info "#{filter.name}: #{ext.join(', ')}"
      end
    end
  end
end
