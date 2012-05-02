require_relative 'transformer'

module Integrate
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
