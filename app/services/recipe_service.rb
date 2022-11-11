class RecipeService
  def self.get_recipe(country)
    api_key = 'a1d62460d191ae34195c195984150c0b'
    app_id = 'f5a8487a'
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