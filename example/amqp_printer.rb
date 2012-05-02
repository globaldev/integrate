require_relative "../lib/integrate/adaptor/inbound/amqp"
require_relative "../lib/integrate/adaptor/outbound/io"
require_relative "../lib/integrate/channel"

include Integrate

received = Channel.new

inbound_adaptor = Adaptor::Inbound::AMQP.new(out: received,
                                                        queue: "testqueue")
outbound_adaptor = Adaptor::Outbound::IO.new(STDOUT, in: received)

inbound_adaptor.start
