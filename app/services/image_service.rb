class ImageService

  def self.get_images(country)

    response = conn.get("?&query=#{country}")
    parse(response.body)
  end

  def self.conn
    Faraday.new('https://api.unsplash.com/search/photos') do |f|
      f.params['client_id'] = ENV['unsplash_access_key']
    end
  end

  def self.parse(response) #check: make this into a module method?
    JSON.parse(response, symbolize_names: true)
  end
end

# def self.get_images(country)
#   access_key = ENV['unsplash_access_key']
#   secret_key = ENV['unsplash_secret_key']
#   response = conn.get("?client_id=#{access_key}&query=#{country}")
#   parse(response.body)
# end