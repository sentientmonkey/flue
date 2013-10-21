require 'fileutils'

module Flue
  class Middleware
    attr_reader :app, :watcher, :renderer

    def initialize(app, watcher, renderer)
      @app = app
      @watcher = watcher
      @renderer = renderer
    end

    def call(env)
      file = File.basename(env['PATH_INFO'])
      basefile = renderer.basefiles.detect{|basefile| basefile.outfile_basename == file }
      if basefile && watcher.changes.include?(basefile.filename)
        renderer.render_file(basefile)
      end
      app.call(env)
    end
  end
end
