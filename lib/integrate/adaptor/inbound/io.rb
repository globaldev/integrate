module Integrate
  module Adaptor
    module Inbound
      class IO
        
        # options should be a hash, with the following available options:
        # [:out] (required) the output channel
        #
        def initialize(io, separator=$/, options)
          @io = io
          @separator = separator
          @output_channel = options[:out]
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
