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
      
      send_successful = false
      
      handlers.each do |handler|
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