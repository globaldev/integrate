require_relative '../../helper'

require 'integrate/transformers/header_enricher'

describe Integrate::Transformers::HeaderEnricher do
  require 'integrate/channel'

  let (:input)  { Channel.new }
  let (:output) { Channel.new }

  describe "when instantiated without headers" do
    subject do
      Integrate::Transformers::HeaderEnricher.new(in: input, out: output) { }
    end

    it "requires headers" do
      must_raise ArgumentError
    end
  end
end
