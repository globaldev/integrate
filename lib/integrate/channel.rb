require_relative 'component'
require_relative 'dispatcher'

module Integrate
  class Channel < Component

    attr_reader :dispatcher

    def initialize(options={})
      super
      @dispatcher = Dispatcher.new
    end

    def register(handler)
      dispatcher.register(handler)
      # TODO Log handler registration with count.
    end

    def unregister(handler)
      dispatcher.unregister(handler)
    end

    def send(message)
      dispatcher.call(message)
    end

  end
end
