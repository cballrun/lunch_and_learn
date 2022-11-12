class Image
  attr_reader :alt_tag,
              :url
  
  def initialize(data)
    @alt_tage = data[:alt_description]
    @url = data[:urls][:raw]
  end
end