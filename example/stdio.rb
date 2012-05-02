require_relative "../lib/integrate/adaptor/inbound/io"
require_relative "../lib/integrate/adaptor/outbound/io"
require_relative "../lib/integrate/handlers/block_transformer"
require_relative "../lib/integrate/channel"

outbound_adaptor = Integrate::Adaptor::Outbound::IO.new(STDOUT)

reverse_to_stdout = Integrate::Channel.new
reverse_to_stdout.subscribe(outbound_adaptor)

reverse = Integrate::BlockTransformer.new(reverse_to_stdout) do |message|
  message["payload"] = message["payload"].reverse
  message
end

upcase_to_reverse = Integrate::Channel.new
upcase_to_reverse.subscribe(reverse)

upcase = Integrate::BlockTransformer.new(upcase_to_reverse) do |message|
  message["payload"] = message["payload"].upcase
  message
end

stdin_to_upcase = Integrate::Channel.new
stdin_to_upcase.subscribe(upcase)

inbound_adaptor = Integrate::Adaptor::Inbound::IO.new(STDIN, stdin_to_upcase)

inbound_adaptor.start
