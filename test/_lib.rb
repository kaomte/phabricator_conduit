require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/setup'

module PhabricatorTests
  class Test < ::MiniTest::Spec
    def setup
      # Put any stubs here that you want to apply globally
    end
  end
end
