require_relative "../lib/integrate/adapters/inbound/io"
require_relative "../lib/integrate/adapters/outbound/io"
require_relative "../lib/integrate/handlers/transformer"
require_relative "../lib/integrate/channel"

include Integrate

inbound = Channel.new
connecting = Channel.new
outbound = Channel.new

stdin = Adapters::Inbound::IO.new(STDIN, out: inbound)

upcaser = Transformer.new(in: inbound, out: connecting) do |message|
  message["payload"] = message["payload"].upcase
  message
end

reverser = Transformer.new(in: connecting, out: outbound) do |message|
  message["payload"] = message["payload"].reverse
  message
end

stdout = Adapters::Outbound::IO.new(STDOUT, in: outbound)

stdin.start
