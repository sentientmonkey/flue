if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

require "minitest/spec"
require "minitest/mock"
require "minitest/autorun"
require "minitest/pride"
require 'sitegen'

include Sitegen
