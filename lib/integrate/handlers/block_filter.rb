require_relative 'filter'

module Integrate
  class BlockFilter < Filter
    
    def initialize(*args, &block)
      @block = block.nil? && args.last.respond_to?(:call) ? args.pop : block
      raise ArgumentError, "BlockFilter requires a block" unless @block
      super(*args)
    end
    
    def allow?(message)
      @block.call(message.dup)
    end
    
  end
end
