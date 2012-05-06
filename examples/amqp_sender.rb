require "bundler/setup"
require "logger"

require "integrate/channel"
require "integrate/channel_adapters/inbound/io"
require "integrate/channel_adapters/outbound/amqp"
require "integrate/workflow"

include Integrate

workflow = Workflow.new do
  logger Logger.new(STDERR)
  log_level :debug
  
  from_stdin Channel
  
  stdin_receiver ChannelAdapters::Inbound::IO, STDIN, out: from_stdin
  
  amqp_sender ChannelAdapters::Outbound::AMQP, in: from_stdin,
                                               exchange: "",
                                               key: "testqueue"
end

workflow.start
