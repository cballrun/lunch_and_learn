class RecipeSerializer
  include JSONAPI::Serializer
  attributes :title, :url, :country, :image

  def id
    
  end
end