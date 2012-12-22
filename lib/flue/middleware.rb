require 'fileutils'

module Flue
  class Middleware
    def initialize(app, watcher, runner)
      @app = app
      @watcher = watcher
      @runner = runner
    end

    def call(env)
      file = File.basename(env['PATH_INFO'])
      basefile = @runner.files.map{|f| Basefile.new(f) }.detect{|f| f.outfile_basename == file }
      if basefile && @watcher.changes.include?(basefile.filename)
        @runner.render_file(basefile.filename)
      end
      @app.call(env)
    end
  end
end
