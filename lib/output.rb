##
# Sends surrender notifications in growl
class Output
  GROWL_CMD = "growlnotify"
  GROWL_OPTS = "-s -m"
  
  def self.send_notification(msg)
    system [GROWL_CMD, GROWL_OPTS, msg].join(' ')
  end
end