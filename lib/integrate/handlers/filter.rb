require_relative '../handler'

module Integrate

  # A filter is a message handler that conditionally passes, or not, the
  # message on to the next stage of the workflow.
  #
  # The Filter class is available as a superclass for any kind of filter,
  # simply subclass and override the #allow? method.
  #
  # Filter may be used without subclassing by supplying a block to ::new,
  # the block will then be invoked to perform the message filtering.
  #
  class Filter < Handler

    def call(message)
      super if allow?(message)
    end

    def allow?(message)
      @block.call(message) if @block
    end

  end
end
