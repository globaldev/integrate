require 'set'

module Integrate
  class Dispatcher
    
    def initialize
      # Registered message handlers
      @handlers = Set[]
    end
    
    def handlers
      @handlers.dup
    end
    
    def register_handler(handler)
      @handlers.add(handler)
    end
    
    def unregister_handler(handler)
      @handlers.delete(handler)
    end
    
    # Will attempt to send message to at most
    # one of its handlers
    def call(message)
      raise StandardError, "Dispatcher has no subscribers" if handlers.empty?
      handlers.any? {|handler| call_with_error_handling(handler, message)}
    end
    
    private
    def call_with_error_handling(handler, message)
      handler.call(message)
      true
    rescue StandardError => e
      # log here
      raise # while in early development
      false
    end
    
  end
end