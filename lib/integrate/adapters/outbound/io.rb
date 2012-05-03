module Integrate
  module Adapters
    module Outbound
      class IO

        # options should be a hash, with the following available options:
        # [:in] (required) the input channel
        #
        def initialize(io, separator=$/, options)
          @io = io
          @separator = separator
          options[:in].register(self)
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
