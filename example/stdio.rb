require_relative "../lib/integrate/adaptor/inbound/io"
require_relative "../lib/integrate/adaptor/outbound/io"
require_relative "../lib/integrate/handlers/block_transformer"
require_relative "../lib/integrate/channel"

include Integrate

inbound = Channel.new
connecting = Channel.new
outbound = Channel.new

stdin = Adaptor::Inbound::IO.new(STDIN, out: inbound)

upcaser = BlockTransformer.new(in: inbound, out: connecting) do |message|
  message["payload"] = message["payload"].upcase
  message
end

reverser = BlockTransformer.new(in: connecting, out: outbound) do |message|
  message["payload"] = message["payload"].reverse
  message
end

stdout = Adaptor::Outbound::IO.new(STDOUT, in: outbound)

stdin.start
