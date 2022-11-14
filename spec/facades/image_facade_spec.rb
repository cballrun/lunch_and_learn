require 'rails_helper'

RSpec.describe ImageFacade do

  it 'gets image data and creates image objects' do
    VCR.use_cassette('laos_image_data') do
      images = ImageFacade.get_images("laos")
      image = images.first

      expect(images).to be_a(Array)
      expect(images.last).to be_a(Image)
      expect(image.alt_tag).to be_a(String)
      expect(image.url).to be_a(String)
    
    end
  end

  it 'returns an empty array if no images are found' do
    VCR.use_cassette('random_string_image') do

      images = ImageFacade.get_images("98asdsa7gghsdfaq55daqwrff")

      expect(images).to eq([])
    end
  end
end