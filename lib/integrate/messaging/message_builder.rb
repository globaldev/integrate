module Integrate
  class MessageBuilder
    
    attr_reader :message
    
    def self.from_headers(headers_hash)
      @message = Message.new()
      @message.headers = headers_hash
      self
    end
    
    def self.with_payload(payload)
      @message = Message.new()
      @message.payload = payload
      self
    end
    
    def self.copy_headers(message)
      @message.headers = message.headers
      self
    end
    
    def self.build
      @message
    end
  end
end