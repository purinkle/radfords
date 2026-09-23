# frozen_string_literal: true
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.

# concurrent-ruby 1.3.5 stopped requiring the logger library itself, and Rails
# 6 reads Logger as it loads Active Support. Every entry point loads this file
# before it loads Rails, so the require belongs here.
require "logger"
