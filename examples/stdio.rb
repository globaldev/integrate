require "bundler/setup"

require "integrate/channel"
require "integrate/handlers/transformer"
require "integrate/channel_adapters/inbound/io"
require "integrate/channel_adapters/outbound/io"

include Integrate

inbound    = Channel.new(id: "from_stdin")
connecting = Channel.new(id: "connecting")
outbound   = Channel.new(id: "to_stdout")

upcaser = Transformer.new(id: "upcaser", in: inbound, out: connecting) do |message|
  message["payload"] = message["payload"].upcase
  message
end

reverser = Transformer.new(id: "reverser", in: connecting, out: outbound) do |message|
  message["payload"] = message["payload"].reverse
  message
end

stdin  = ChannelAdapters::Inbound::IO.new(STDIN, out: inbound)
stdout = ChannelAdapters::Outbound::IO.new(STDOUT, in: outbound)

stdin.start
