# CPIU - a Ruby interface for fetching CPI-U data from BLS.gov
# Copyright (C) 2017 Cody Logan
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'simplecov'
require 'simplecov-lcov'
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start

require 'bundler/setup'
require 'webmock/rspec'
require 'vcr'
require 'cpiu'
require 'json'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<SECURE>') do |interaction|
    JSON(interaction.request.body)['registrationkey']
  end
end
