require "fileutils"
require "yaml"
require "rack"
require 'ostruct'
require 'optparse'


module Flue
  class Runner
    include Flue::Benchmark
    include Flue::Logger

    def files
      Dir["site/[^_]*"] - Dir["site/*.yml"]
    end

    def render_files
      #TODO refactor out
      files.each do |file|
        basefile = Basefile.new(file)
        File.open(basefile.outfile_name, "w") do |f|
          benchmark "#{basefile.basename} => #{basefile.outfile_name}" do
            options = {}
            data = basefile.datafile
            if data
              options[:variables] = YAML.load(data)
            end
            f.write FilterRegister.run(basefile.exts, basefile.content, options)
          end
        end
      end
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
      render_files
      if options.run_server
        server
      end
    end

    def server
      app = Rack::Builder.new do
        run Rack::Directory.new(File.join([Dir.pwd, "_site"]))
      end
      Rack::Server.start :app => app, :Port => 9292
    end

  end
end
