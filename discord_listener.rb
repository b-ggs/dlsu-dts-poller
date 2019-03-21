require 'discordrb'
require './lib/runner'
require './lib/formatter'

bot = Discordrb::Commands::CommandBot.new(
  token: ENV['DISCORD_BOT_TOKEN'],
  prefix: '!'
)

checknow_args = {
  min_args: 0,
  max_args: 0,
  description: 'Check now',
  usage: '!checknow'
}

bot.command(:checknow, checknow_args) do |_event|
  data = Runner.run
  formatted = Formatter.run(data, __FILE__)
end

bot.run
