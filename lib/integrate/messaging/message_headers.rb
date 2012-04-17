module Integrate
  class MessageHeaders
    
    attr_reader :headers
    
    def initialize(headers_map)
      raise ArgumentError unless headers_valid?(headers_map)
      @headers = headers_map
    end
    
    private
    
    def headers_valid?(headers_map)
      headers_map.inject(false) do |result, (r, y)|
        result = true if r.is_a?(String)
      end
    end
  end
  
end