require_relative 'options'

module Integrate

  # A Component describes any part of the integration workflow, and
  # encapsulates attributes common to all components.
  #
  class Component
    extend Options

    option :id, public: true, default: -> {self.class.generate_id}

    def self.generate_id
      @counter = @counter ? @counter + 1 : 0
      "#{name}-#{@counter}"
    end

  end
end
