require_relative '../../options'

module Integrate
  module ChannelAdapters
    module Outbound
      class IO
        extend Options

        option :in, :input_channel, required: true

        # options should be a hash, with the following available options:
        # [:in] (required) the input channel
        #
        def initialize(io, separator=$/, options)
          super(options)

          input_channel.register(self)

          @io        = io
          @separator = separator
        end

        def call(message)
          output = message["payload"].to_s
          output += @separator if @separator

          @io.write(output)
        end

      end
    end
  end
end
