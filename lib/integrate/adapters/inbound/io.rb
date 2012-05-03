require_relative '../../options'

module Integrate
  module Adapters
    module Inbound
      class IO
        extend Options

        option :out, :output_channel, required: true

        # options should be a hash, with the following available options:
        # [:out] (required) the output channel
        #
        def initialize(io, separator=$/, options)
          super(options)
          @io = io
          @separator = separator
        end

        def start
          while line = @io.gets(@separator)
            @output_channel.send({"payload" => line.chomp(@separator)})
          end
        end

      end
    end
  end
end
