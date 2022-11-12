class VideoService

  def self.get_a_video(country)
    api_key = 'AIzaSyCycf61l0O2MfB969KdmCUiGRhh7aFfOOY'
    response = conn.get("?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&maxResults=1&q=#{country}&key=#{api_key}")
    parse(response.body)
  end

  def self.conn
    Faraday.new('https://youtube.googleapis.com/youtube/v3/search')
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end

end