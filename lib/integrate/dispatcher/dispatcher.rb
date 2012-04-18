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
  end
end