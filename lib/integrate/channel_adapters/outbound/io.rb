require 'integrate/options'
require 'integrate/channel_adapters/outbound/abstract_outbound_channel_adapter'

module Integrate
  module ChannelAdapters
    module Outbound
      class IO < AbstractOutboundChannelAdapter

        def initialize(io, separator=$/, options)
          super(options)

          @io        = io
          @separator = separator
        end

        def call(message)
          super(message)
          output = message["payload"].to_s
          output += @separator if @separator
          
          @io.write(output)
        end

      end
    end
  end
end
