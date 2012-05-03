require_relative 'transformer'

module Integrate
  
  # A Header Enricher is used to add headers to a Message.
  #
  # The HeaderEnricher class is available as a superclass when header values 
  # must be resolved dynamically based upon message content; simply subclass 
  # and override the #transform method.
  #
  # When headers need not be resolved dynamically, a Hash of static headers and 
  # values may be supplied to HeaderEnricher.
  #
  class HeaderEnricher < Transformer
    
    option :headers, required: true
    option :overwrite
    
    def initialize(options)
      super
      if headers.key?("payload")
        raise ArgumentError, "HeaderEnricher is unable to enrich payload"
      end
    end
    
    def transform(message)
      result = message.dup
      @headers.each do |header, val|
        result[header] = val unless result[header] && !@overwrite
      end
      result
    end

  end
end
