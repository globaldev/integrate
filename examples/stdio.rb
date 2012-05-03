require "bundler/setup"
require "logger"

require "integrate/channel"
require "integrate/transformer"
require "integrate/channel_adapters/inbound/io"
require "integrate/channel_adapters/outbound/io"
require "integrate/workflow"

include Integrate

workflow = Workflow.new do
  logger Logger.new(STDERR)
  log_level :debug
  
  from_stdin Channel
  connecting Channel
  to_stdout Channel
  
  stdin ChannelAdapters::Inbound::IO, STDIN, out: from_stdin
  
  upcaser Transformer, in: from_stdin, out: connecting do |message|
    message["payload"] = message["payload"].upcase
    message
  end
  
  reverser Transformer, in: connecting, out: to_stdout do |message|
    message["payload"] = message["payload"].reverse
    message
  end
  
  stdout ChannelAdapters::Outbound::IO, STDOUT, in: to_stdout
end

workflow.start
