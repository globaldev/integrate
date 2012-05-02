module Integrate
  module Adaptor
    module Outbound
      class IO
        
        def initialize(io, separator=$/)
          @io = io
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
