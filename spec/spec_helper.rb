require 'rspec'
require File.dirname(__FILE__) + '/../lib/surrender'

require 'time'

RSpec.configure do |config|
  # config details here
  # using non-default mocks/stubs
  def sooner_time
    Time.local 2009
  end
  
  def later_time
    sooner_time + 600 # ten minutes later
  end
end
