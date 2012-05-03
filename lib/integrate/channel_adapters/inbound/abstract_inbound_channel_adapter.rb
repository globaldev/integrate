require 'integrate/abstract_handler'

module Integrate
  module ChannelAdapters
    module Inbound
      class AbstractInboundChannelAdapter < AbstractHandler

        option :out, :output_channel, required: true

        # options should be a hash, with the following available options:
        # [:out] (required) the output channel
        #
        def initialize(options)
          super
        end

      end
    end
  end
end
