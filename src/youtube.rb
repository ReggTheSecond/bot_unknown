require 'yt'
class YouTube
  attr_accessor :channel
  attr_accessor :videos
  WATCH = "https://www.youtube.com/watch?v="
  def initialize()
    Yt.configure do |config|
      config.log_level = :debug
      config.api_key = ''
    end
    @channel = Yt::Channel.new id: 'UCLtPX8KiXi_hyMNTFxlHNAQ'
    @videos = channel.videos
    # video = Yt::Video.new id: 'w_G2OyOEKL4'
    # puts video.title
  end

  def get_most_recent_video()
    return @videos.where(order: 'date').first()
  end

  def get_most_popular_video()
    return @videos.where(order: 'rating').first()
  end

  def get_link_to_most_recent_video()
    return "#{WATCH}#{get_most_recent_video().id()}"
  end

  def get_link_to_most_popular_video()
    return "#{WATCH}#{get_most_popular_video().id()}"
  end
end
