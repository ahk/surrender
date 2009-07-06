class TimeDuration
  attr_accessor :seconds
  
  def initialize(int = nil)
    @seconds = int
  end
  
  def self.parse_duration(time_string)
    TimeDuration.new 1
  end
end