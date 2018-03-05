require 'discordrb'
require_relative 'youtube.rb'

token = ARGV[0]
client_id = ARGV[1]

bot = Discordrb::Bot.new token: token, client_id: client_id

bot.message(with_text: /~/) do |event|
  tube = YouTube.new()
  event.respond tube.get_link_to_most_recent_video()
end
bot.run()
