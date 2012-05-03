module Integrate
  class Workflow
    LOG_LEVELS = [:debug, :info, :warn, :error, :fatal, :unknown]
    
    class ComponentBuilder
      def initialize(name, klass, *args, options, block)
        @klass = klass
        @args = args
        @options = options
        @options[:id] ||= name
        @block = block
      end
      
      def build
        return @component if @component
        @component = @klass.new(*@args, @options, &@block) if @klass
      end
    end
    
    class Builder < BasicObject
      def initialize(default_opts={})
        @__default_opts__ = default_opts
        @__components__ = {}
      end
      
      def logger(logger=:no_args_semaphore)
        return @__logger__ if logger == :no_args_semaphore
        @__logger__ = logger
        logger.level = log_level
      end
      
      def log_level(level=:no_args_semaphore)
        return @__log_level__ if level == :no_args_semaphore
        @__log_level__ = LOG_LEVELS.index(level) || level
        logger.level = log_level if logger
      end
      
      def method_missing(name, *args, &block)
        if args.empty? && @__components__.key?(name)
          return @__components__[name].build
        elsif @__components__.key?(name)
          ::Kernel.raise "#{name} already set"
        elsif args.empty?
          ::Kernel.raise "#{name} not set"
        end
        
        if ::Hash === args.last
          opts = @__default_opts__.merge(args.pop)
        else
          opts = @__default_opts__.dup
        end
        opts[:logger] = logger if logger
        
        @__components__[name] = ComponentBuilder.new(name, *args, opts, block)
        nil
      end
      
      def to_a
        @__components__.keys.map {|key| __send__(key)}
      end
    end
    
    def initialize(&block)
      builder = Builder.new
      builder.instance_eval(&block)
      components = builder.to_a
      @startable = components.select {|component| component.respond_to?(:start)}
    end
    
    def start
      @threads = @startable.map {|component| Thread.new {component.start}}
      @threads.map(&:join)
    end
    
    def stop(wait=30)
      @startable.map {|component| component.stop if component.respond_to?(:stop)}
      wait -= sleep 1 until @threads.list.empty? || wait <= 0
      @threads.list.each {|thread| thread.kill}.empty?
    end
    
  end
end
