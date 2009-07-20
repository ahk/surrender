module Surrender
  class DependencyError < StandardError; self; end
  
  class SystemInfo
    def self.check_dependencies
      raise DependencyError, "Only Mac OS X is supported at this time" unless current_platform == 'macosx'
      raise DependencyError, "Surrender requires growlnotify to be installed" unless has_growl_notify?
    end
    
    def self.current_platform
      case `uname`
      when /Darwin/
        'macosx'
      end
    end
    
    def self.has_growl_notify?
      system "growlnotify -v"
    end
  end
end