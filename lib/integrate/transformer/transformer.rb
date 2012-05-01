require_relative '../handler/message_handler'

module Integrate
  class Transformer < MessageHandler
    
    def call(message)
      result = transform(message)
      super(result)
    end
  
  end
end
