module Surrender
  ##
  # Sends surrender notifications in growl
  class Output
    GROWL_CMD = "growlnotify"
    GROWL_OPTS = "-s -m"
  
    def self.double_quote(text)
      %Q("#{text}")
    end
  
    def self.send_notification(msg)
      text = double_quote msg.text
      system [GROWL_CMD, GROWL_OPTS, text].join(' ')
    end
  end
end