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
      basefile = find_basefile(env)
      render_if_changed basefile
      app.call(env)
    end

    def find_basefile(env)
      file = File.basename(env['PATH_INFO'])
      renderer.basefiles.detect{|basefile| basefile.outfile_basename == file }
    end

    def render_if_changed(basefile)
      if basefile && watcher.changes.include?(basefile.filename)
        renderer.render_file(basefile)
      end
    end
  end
end
