require 'discordrb/webhooks'
require './lib/runner'
require './lib/formatter'

SHORT_POLL_START = DateTime.parse('March 22, 2019 7:28 pm +0800').to_time.to_i.freeze
SHORT_POLL_DURATION = 300.freeze
SHORT_POLL_INTERVAL = 30.freeze

REGULAR_POLL_INTERVAL = 3600.freeze

def log(msg)
  puts "#{Time.now.to_s} - #{msg}"
end

while true do
  log("Starting...")
  time_int = Time.now.to_i

  sleep_time =
    if time_int >= SHORT_POLL_START && time_int < SHORT_POLL_START + SHORT_POLL_DURATION
      SHORT_POLL_INTERVAL
    else
      REGULAR_POLL_INTERVAL
    end
  log("Will sleep for #{sleep_time}")

  data = Runner.run
  formatted = Formatter.run(data, __FILE__)

  # puts formatted
  client = Discordrb::Webhooks::Client.new(url: ENV['DISCORD_WEBHOOK_URL'])
  client.execute { |builder| builder.content = formatted }

  log("Sleeping for #{sleep_time}")
  sleep sleep_time
end
