if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

require "minitest/mock"
require "minitest/pride"
require "minitest/autorun"
require 'flue'

include Flue
