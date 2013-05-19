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
      basefile = renderer.files.map{|f| Basefile.new(f) }.detect{|f| f.outfile_basename == file }
      if basefile && watcher.changes.include?(basefile.filename)
        renderer.render_file(basefile.filename)
      end
      app.call(env)
    end
  end
end
