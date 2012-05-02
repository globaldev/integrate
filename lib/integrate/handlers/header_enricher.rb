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
    
    def initialize(options)
      check_options(options)
      super(options)
      @headers = options[:headers]
      @overwrite = options[:overwrite] || false
    end
    
    def check_options(options)
      raise ArgumentError, "HeaderEnricher must be provided :headers" unless options[:headers]
      raise ArgumentError, "HeaderEnricher is unable to enrich payload" if options[:headers]["payload"]
    end
    
    def transform(message)
      result = message.dup
      
      @headers.each do |header, val|
        result[header] = 
        case result[header]
        when nil
          val
        else
          @overwrite ? val : result[header]
        end
      end
      result
    end

  end
end
