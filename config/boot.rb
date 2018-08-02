ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
# changes for the ide debug
require "bootsnap/setup" unless ENV["RUBYLIB"]&.match?(/ruby-debug-ide/)

