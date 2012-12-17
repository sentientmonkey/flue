require 'logger'

module Sitegen
  module Logger
    DEFAULT_LOGGER = ::Logger.new($stdout)
    @@logger = DEFAULT_LOGGER

    def self.logger=(logger)
      @@logger = logger
    end

    def logger
      @@logger || DEFAULT_LOGGER
    end
  end
end
