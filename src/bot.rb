require 'discordrb'
require 'date'
require "yaml"
require_relative 'youtube.rb'

class ChannelManager
  attr_accessor :channels

  def initialize()
    @channels = Array.new()
  end

  def add_channel_to_manager(channel)
    if does_not_contain_channel(channel)
      @channels << channel
    end
  end

  def does_not_contain_channel(channel)
    @channels.each do |channel_in_manager|
      if channel_in_manager.name == channel.name
        return false
      end
    end
    return true
  end
end

class Thing
  attr_accessor :most_recent_posted_video
  attr_accessor :time_last_video_was_posted
  attr_accessor :bot
  attr_accessor :channel_manager
  attr_accessor :youtube
  RECENTLY_POSTED_FILE = "data/recently_posted_video.txt"
  VIDEO_POST_CHANNEL = "to-be-deleteable"

  def initialize(bot, channel_manager)
    @bot = bot
    @channel_manager = channel_manager
    @youtube = YouTube.new()
    @time_last_video_was_posted = DateTime.now()
    Thread.new{update_most_recent_posted_video()}
  end

  def update_channel_manager(channel_manager)
    @channel_manager = channel_manager
  end

  def update_most_recent_posted_video()
    next_time = @time_last_video_was_posted + 0.0002
    while DateTime.now() < next_time
    end
    post_video()
  end

  def post_video()
    @bot.send_message(get_youtube_channels(VIDEO_POST_CHANNEL), @youtube.get_link_to_most_recent_video(), false, nil)
  end

  def get_youtube_channels(wanted_channel)
    @channel_manager.channels.each do |channel|
      if channel.name == channel.name
        return channel
      end
    end
  end
end
CHANNEL_MANAGER_FILE = "data/channel_manager.yaml"

def save_as_YAML(channel_manager)
  File.open(CHANNEL_MANAGER_FILE, 'w') do |file|
      file.write YAML::dump(channel_manager)
  end
end

def load_channel_manager()
  return YAML.load_file(CHANNEL_MANAGER_FILE)
end

token = ""#ARGV[0]
client_id = #ARGV[1]

if File.exist?(CHANNEL_MANAGER_FILE)
  channel_manager = load_channel_manager()
else
  channel_manager = ChannelManager.new()
  save_as_YAML(channel_manager)
end

bot = Discordrb::Bot.new token: token, client_id: client_id
thing = Thing.new(bot, channel_manager)

bot.message(with_text: /~/) do |event|
  channel_manager.add_channel_to_manager(event.channel)
  save_as_YAML(channel_manager)
  thing.update_channel_manager(channel_manager)
end

bot.run()
