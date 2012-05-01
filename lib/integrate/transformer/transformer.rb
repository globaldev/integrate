module Integrate
  class Transformer < MessageHandler
    
    def call(message)
      result = transform(message)
      super(result)
    end
  
  end
end
