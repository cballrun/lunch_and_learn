class ImageFacade

  def self.get_images(country)
    images = ImageService.get_images(country)
    images[:results].map do |image|
      Image.new(image)
    end
  end
end