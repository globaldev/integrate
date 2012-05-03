require "bundler/setup"

require "integrate/channel"
require "integrate/channel_adapters/inbound/amqp"
require "integrate/channel_adapters/outbound/io"

include Integrate

received = Channel.new(id: "stdin_received")

inbound_adaptor = ChannelAdapters::Inbound::AMQP.new(out: received,
                                                     queue: "testqueue")
outbound_adaptor = ChannelAdapters::Outbound::IO.new(STDOUT, in: received)

inbound_adaptor.start
