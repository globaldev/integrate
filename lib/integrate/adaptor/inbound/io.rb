module Integrate
  module Adaptor
    module Inbound
      class IO
        
        def initialize(io, separator=$/, output_channel)
          @io = io
          @separator = separator
          @output_channel = output_channel
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
