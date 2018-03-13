require "yaml"

CHANNEL_MANAGER_FILE = "data/channel_manager.yaml"

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

def save_as_YAML(channel_manager)
  File.open(CHANNEL_MANAGER_FILE, 'w') do |file|
      file.write YAML::dump(channel_manager)
  end
end

channel_manager = ChannelManager.new()
channel_manager.add_channel_to_manager("THING")
save_as_YAML(channel_manager)
