require_relative "../lib/integrate/adaptor/outbound/amqp"
require_relative "../lib/integrate/adaptor/inbound/io"
require_relative "../lib/integrate/channel"

include Integrate

received = Channel.new

stdin = Adaptor::Inbound::IO.new(STDIN, out: received)

outbound_adaptor = Adaptor::Outbound::AMQP.new(in: received,
                                               exchange: "",
                                               key: "testqueue")
stdin.start
