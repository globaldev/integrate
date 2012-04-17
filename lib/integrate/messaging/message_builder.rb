module Integrate
  class MessageBuilder
    
    def self.from_headers(headers_hash)
      message = Message.new()
      message.headers = headers_hash
      message
    end
    
    def self.with_payload(payload)
      message = Message.new()
      message.payload = payload
      message
    end
  end
end