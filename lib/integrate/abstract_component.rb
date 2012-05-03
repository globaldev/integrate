require_relative 'options'

module Integrate

  # An AbstractComponent describes any part of the integration workflow, and
  # encapsulates attributes common to all components.
  #
  class AbstractComponent
    extend Options

    option :id, public: true, default: -> { self.class.generate_id }
    option :logger

    def self.generate_id
      @counter = @counter ? @counter + 1 : 0
      "#{name}-#{@counter}"
    end

  end
end
