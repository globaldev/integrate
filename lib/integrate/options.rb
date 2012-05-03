module Integrate
  module Options
    
    module Initialize
      def initialize(opts={})
        self.class.options.each do |name, (accessor, required, default)|
          if opts.key?(name)
            value = opts[name]
          elsif default.respond_to?(:to_proc)
            value = instance_exec(&default)
          elsif !default.nil?
            value = default
          elsif required
            raise ArgumentError, "option :#{name} required"
          end
          instance_variable_set(:"@#{accessor}", value)
        end
      end
    end
    
    def self.extended(extender)
      extender.instance_eval {include(Initialize)}
    end
    
    def set_options(instance, opts)
      options.each do |name, (accessor, required, default)|
        if opts.key?(name)
          value = opts[name]
        elsif default.respond_to?(:to_proc)
          value = instance.instance_exec(&default)
        elsif !default.nil?
          value = default
        elsif required
          raise ArgumentError, "option :#{name} required"
        end
        instance.instance_variable_set(:"@#{accessor}", value)
      end
    end

    def options
      @options ||= {}
    end

    # :call-seq:
    # option(name)
    # option(name, accessor)
    # option(name, opts)
    # option(name, accessor, opts)
    #
    # +name+ should be a symbol, and will be the key used to retrieve the value
    # from the options hash given to initialize
    #
    # +accessor+ should be a symbol and will be the method/ivar the instance can
    # use to access the value after initialization. If not provided, will
    # default to +name+
    #
    # +opts+ is a hash that can contain the following
    # [:required]  if true, the initializer will raise ArgumentError if the
    #              option isn't provided. Defaults to false
    # [:public]    if true, the accessor method generated will be public.
    #              Defaults to false
    # [:writeable] if true a write accessor is generated. Defaults to false
    #
    def option(*args)
      unless (1..3) === args.size
        raise ArgumentError, "wrong number of arguments (#{args.size} for 1..3)"
      end
      name = args.shift
      opts = Hash === args.last ? args.pop : {}
      accessor = args.pop || name

      options[name] = [accessor, *opts.values_at(:required, :default)]
      attr_reader accessor
      attr_writer accessor if opts[:writeable]
      private accessor unless opts[:public]
      nil
    end

    private :option
    attr_writer :options
    protected :options=

    def inherited(inheritor)
      super
      inheritor.options = options.dup
    end

  end
end
