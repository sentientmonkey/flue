require 'logger'

module Sitegen
  module Logger
    DEFAULT_LOGGER = ::Logger.new($stdout)

    def self.included(base)
      base.extend ClassMethods
    end

    def logger
      self.class.logger || DEFAULT_LOGGER
    end

    module ClassMethods
      def logger
        @logger
      end

      def logger=(new_logger)
        @logger = new_logger
      end
    end

  end
end
