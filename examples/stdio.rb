require_relative "../lib/integrate/adapters/inbound/io"
require_relative "../lib/integrate/adapters/outbound/io"
require_relative "../lib/integrate/handlers/transformer"
require_relative "../lib/integrate/channel"

include Integrate

inbound = Channel.new(id: "from_stdin")
connecting = Channel.new(id: "connecting")
outbound = Channel.new(id: "to_stdout")

stdin = Adapters::Inbound::IO.new(STDIN, out: inbound)

upcaser = Transformer.new(id: "upcaser", in: inbound, out: connecting) do |message|
  message["payload"] = message["payload"].upcase
  message
end

reverser = Transformer.new(id: "reverser", in: connecting, out: outbound) do |message|
  message["payload"] = message["payload"].reverse
  message
end

stdout = Adapters::Outbound::IO.new(STDOUT, in: outbound)

stdin.start
