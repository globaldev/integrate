require_relative "../lib/integrate/adapters/outbound/amqp"
require_relative "../lib/integrate/adapters/inbound/io"
require_relative "../lib/integrate/channel"

include Integrate

received = Channel.new

stdin = Adapters::Inbound::IO.new(STDIN, out: received)

outbound_adaptor = Adapters::Outbound::AMQP.new(in: received,
                                                exchange: "",
                                                key: "testqueue")
stdin.start
