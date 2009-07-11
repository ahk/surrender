module Surrender
  ##
  # Represents the kind of message sent in a growl notification
  class GrowlMessage
    attr_accessor :text
  
    def initialize(text)
      @text = text
    end
  end
end