require "bundler/setup"
require "logger"

require "integrate/channel"
require "integrate/channel_adapters/inbound/amqp"
require "integrate/channel_adapters/outbound/io"
require "integrate/workflow"

include Integrate

workflow = Workflow.new do
  logger Logger.new(STDERR)
  log_level :debug
  
  received Channel
  
  amqp_receiver ChannelAdapters::Inbound::AMQP, out: received, queue: "testqueue"
  
  message_printer ChannelAdapters::Outbound::IO, STDOUT, in: received
end

workflow.start
