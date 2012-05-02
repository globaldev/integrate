require_relative 'splitter'

module Integrate
  class BlockSplitter < Splitter
    
    def initialize(*args, &block)
      @block = block.nil? && args.last.respond_to?(:call) ? args.pop : block
      raise ArgumentError, "BlockSplitter requires a block" unless @block
      super(*args)
    end
    
    def split(message)
      @block.call(message.dup)
    end
    
  end
end
