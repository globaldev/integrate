require_relative '../handler'

module Integrate
  class Transformer < Handler
    
    def call(message)
      result = transform(message)
      super(result)
    end
  
  end
end
