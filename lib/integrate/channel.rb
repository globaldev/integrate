require 'integrate/abstract_component'
require 'integrate/dispatcher'

module Integrate
  class Channel < AbstractComponent

    attr_reader :dispatcher

    def initialize(options={})
      super
      @dispatcher = Dispatcher.new
    end

    def register(handler)
      if logger
        logger.debug("Registering Handler [#{handler.id}] with Channel " +
                     "[#{id}]")
      end
      dispatcher.register(handler)
    end

    def unregister(handler)
      dispatcher.unregister(handler)
    end

    def send(message)
      dispatcher.call(message)
    end

  end
end
