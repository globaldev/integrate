require 'integrate/abstract_transformer'

module Integrate
  module Transformers

    # A Header Enricher is used to add headers to a Message.
    #
    # The HeaderEnricher class is available as a superclass when header values
    # must be resolved dynamically based upon message content; simply subclass
    # and override the #transform method.
    #
    # When headers need not be resolved dynamically, a Hash of static headers and
    # values may be supplied to HeaderEnricher.
    #
    class HeaderEnricher < AbstractTransformer

      def initialize(options)
        check_options(options)

        super(options)

        @headers   = options[:headers]
        @overwrite = options[:overwrite] || false
      end

      def check_options(options)
        if !options.key?(:headers)
          raise ArgumentError, "HeaderEnricher must be provided :headers"
        elsif options[:headers]["payload"]
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
end
