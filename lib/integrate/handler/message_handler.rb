module Integrate
  class MessageHandler
    
    attr_accessor :output_channel
    
    def call(message)
      output_channel.send(message) if output_channel
    end
    
  end
end
