module Integrate
  class MessageHeaders
    
    attr_reader :headers
    
    def initialize(headers_map)
      raise ArgumentError unless headers_valid?(headers_map)
      @headers = headers_map
    end
    
    private
    
    def headers_valid?(headers_map)
      headers_map.each {|k, v| return false if !k.is_a?(String)}
    end
  end
end