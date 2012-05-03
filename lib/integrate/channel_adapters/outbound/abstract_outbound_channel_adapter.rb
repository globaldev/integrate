module Integrate
  module ChannelAdapters
    module Outbound
      class AbstractOutboundChannelAdapter < AbstractHandler

        option :in, :input_channel, required: true

        # options should be a hash, with the following available options:
        # [:in] (required) the input channel
        #
        def initialize(options)
          super
        end

      end
    end
  end
end
