require "bundler/setup"

require "integrate/channel"
require "integrate/channel_adapters/inbound/io"
require "integrate/channel_adapters/outbound/amqp"

include Integrate

received = Channel.new(id: "amqp_received")

stdin = ChannelAdapters::Inbound::IO.new(STDIN, out: received)

outbound_adaptor = ChannelAdapters::Outbound::AMQP.new(in: received,
                                                       exchange: "",
                                                       key: "testqueue")
stdin.start
