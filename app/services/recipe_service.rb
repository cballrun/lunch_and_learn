class RecipeService
  def self.get_recipes(country)
    api_key = ENV['edamam_api_key']
    app_id = ENV['edamam_app_id']
    response = conn.get("?q=#{country}&app_id=#{app_id}&app_key=#{api_key}")
    parse(response.body)
  end

  def self.conn
    Faraday.new('https://api.edamam.com/search')
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end