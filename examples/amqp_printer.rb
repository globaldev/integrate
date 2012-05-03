require_relative "../lib/integrate/adapters/inbound/amqp"
require_relative "../lib/integrate/adapters/outbound/io"
require_relative "../lib/integrate/channel"

include Integrate

received = Channel.new

inbound_adaptor = Adapters::Inbound::AMQP.new(out: received,
                                                        queue: "testqueue")
outbound_adaptor = Adapters::Outbound::IO.new(STDOUT, in: received)

inbound_adaptor.start
