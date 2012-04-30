module Integrate
  class Dispatcher
    
    def initialize
      # Registered message handlers
      @handlers = {}
    end
    
    def handlers
      @handlers.dup
    end
    
    def register_handler(handler)
      @handlers[handler.hash] = handler
    end
    
    def unregister_handler(handler)
      @handlers.delete(handler.hash)
    end
    
    # Will attempt to send message to at most
    # one of its handlers
    def call(message)
      raise StandardError, "Dispatcher has no subscribers" if handlers.empty?
      
      send_successful = false
      
      handlers.each do |hash, handler|
        break if send_successful
        begin
          handler.call(message)
          send_successful = true
        rescue StandardError => e
          raise e
        end
      end
      
      send_successful
    end
  end
end