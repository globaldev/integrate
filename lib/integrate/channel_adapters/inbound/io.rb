require 'integrate/options'
require 'integrate/channel_adapters/inbound/abstract_inbound_channel_adapter'

module Integrate
  module ChannelAdapters
    module Inbound
      class IO < AbstractInboundChannelAdapter

        def initialize(io, separator=$/, options)
          super(options)

          @io        = io
          @separator = separator
        end

        def start
          while line = @io.gets(@separator)
            call({"payload" => line.chomp(@separator)})
          end
        end

      end
    end
  end
end
