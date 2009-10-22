require 'spec'
require File.dirname(__FILE__) + '/../lib/surrender'

require 'time'

Spec::Runner.configure do |config|
  # config details here
  # using non-default mocks/stubs
  def sooner_time
    Time.parse 'Wed Oct 21 16:47:07 -0700 2009'
  end
  
  def later_time
    Time.parse 'Wed Oct 21 16:58:11 -0700 2009'
  end
end