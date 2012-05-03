module Integrate
  
  # A Component describes any part of the integration workflow, and 
  # encapsulates attributes common to all components.
  #
  class Component

    attr_reader :id

    # options should be a hash, with the following available options:
    # [:id] the component id
    #
    def initialize(options={})
      @id = options[:id] || self.class.generate_id
    end
    
    def self.generate_id
      @counter ||= -1
      @counter += 1
      "#{name}-#{@counter}"
    end

  end
end
