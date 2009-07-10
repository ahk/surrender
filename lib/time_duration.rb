class TimeDuration
  attr_accessor :seconds
  
  def initialize(int = nil)
    @seconds = int.to_i
  end
  
  def ==(other_duration)
    self.seconds == other_duration.seconds
  end
  
  def self.parse_duration(time)
    # don't parse if it's already an integer
    return self.new(time) if time.instance_of? Fixnum
    
    num_reg = /[0-9]+/
    case time
    when /hours/
      secs = hours_to_seconds time.match(num_reg)[0]
      self.new secs
    when /minutes/
      secs = minutes_to_seconds time.match(num_reg)[0]
      self.new secs
    when /seconds/
      self.new time.match(num_reg)[0]
    end
  end
  
  private
  def self.minutes_to_seconds minutes
    minutes.to_i * 60
  end
  
  def self.hours_to_seconds hours
    hours.to_i * 3600
  end
end