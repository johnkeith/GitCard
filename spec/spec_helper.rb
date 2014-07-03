require 'webmock/rspec'
require "rack_session_access/capybara"
require 'coveralls'
WebMock.disable_net_connect!(allow_localhost: true)

Coveralls.wear!('rails')

RSpec.configure do |config|

end
