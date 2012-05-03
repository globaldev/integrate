require 'integrate/abstract_component'

module Integrate
  class AbstractHandler < AbstractComponent

    option :in, :input_channel
    option :out, :output_channel

    # options should be a hash, with the following available options:
    # [:in]  the input channel
    # [:out] the output channel
    #
    def initialize(options, &block)
      super
      input_channel.register(self) if input_channel
      @block = block if block
    end

    def call(message)
      if logger
        logger.debug("Handler [#{@id}] received Message [#{message.inspect}]")
      end
      
      output(message) if output_channel
    end

    def output(message)
      if logger
        logger.debug("Handler [#{@id}] sending Message [#{message.inspect}] " + 
                     "to Channel [#{@output_channel.id}]")
      end
      
      output_channel.send(message)
    end

  end
end
