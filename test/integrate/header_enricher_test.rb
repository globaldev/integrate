require_relative '../helper'

require 'integrate/header_enricher'
require 'integrate/channel'

module Integrate
  class HeaderEnricherTest < MiniTest::Unit::TestCase

    def enricher(options)
      HeaderEnricher.new(in: Channel.new,
                         out: Channel.new,
                         headers: options[:headers],
                         overwrite: options[:overwrite])
    end

    def test_requires_headers
      assert_raises(ArgumentError) do
        HeaderEnricher.new(in: Channel.new,
                           out: Channel.new)
      end
    end

    def test_rejects_payload_enrichment
      assert_raises(ArgumentError) do
        enricher = enricher(headers:{"payload" => "foo"})
      end
    end

    def test_instantiation
      enricher = enricher(headers:{"key" => "val"})
      refute_nil(enricher)
    end

    def test_headers_added
      enricher = enricher(headers:{"region" => "uk"})
      input = {"id" => 123,}
      expected = {"id" => 123, "region" => "uk"}

      assert_equal(expected, enricher.transform(input))
    end

    def test_headers_not_overwritten_by_default
      enricher = enricher(headers:{"region" => "uk"})
      input = {"region" => "de"}
      expected = {"region" => "de"}

      assert_equal(expected, enricher.transform(input))
    end

    def test_headers_overwritten_when_configured
      enricher = enricher(headers: {"region" => "uk"}, overwrite: true)
      input = {"region" => "de"}
      expected = {"region" => "uk"}

      assert_equal(expected, enricher.transform(input))

    end
  end
end
