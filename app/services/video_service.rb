class VideoService

  def self.get_a_video(country)
    api_key = ENV['youtube_api_key']
    response = conn.get("?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&maxResults=1&q=#{country}&key=#{api_key}") #check: maybe take out hard coded max results and use only the .first in the facade to make more dynamic
    parse(response.body)
  end

  def self.conn
    Faraday.new('https://youtube.googleapis.com/youtube/v3/search')
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end

end