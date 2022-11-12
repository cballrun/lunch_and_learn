class ImageService

  def self.get_images(country)
    access_key = 'H_aFp-PGCc9GZkfVHgx-m7tx-SqCt1MTBqeyWuG6CL4'
    secret_key = 'OxMggLFDWRilwEL_7WENrqsgjwCcIgE-LULtd3Y1yxE'
    response = conn.get("?client_id=#{access_key}&query=#{country}")
    parse(response.body)
  end

  def self.conn
    Faraday.new('https://api.unsplash.com/search/photos')
  end

  def self.parse(response) #check: make this into a module method?
    JSON.parse(response, symbolize_names: true)
  end
end