require_relative 'transformer'

module Integrate
  class BlockTransformer < Transformer
    
    def initialize(*args, &block)
      @block = block.nil? && args.last.respond_to?(:call) ? args.pop : block
      super(*args)
    end
    
    def transform(message)
      @block.call(message.dup)
    end
    
  end
end
