require_relative 'dispatcher'

module Integrate
  class Channel
    
    attr_reader :dispatcher
    
    def initialize
      @dispatcher = Dispatcher.new
    end
    
    def subscribe(message_handler)
      dispatcher.register_handler(message_handler)
      # TODO Log handler registration with count.
    end
    
    def unsubscribe(message_handler)
      dispatcher.unregister_handler(message_handler)
    end
    
    def send(message)
      dispatcher.call(message)
    end
    
  end
end
