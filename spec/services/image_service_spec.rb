require 'rails_helper'

RSpec.describe ImageService do
  describe 'API endpoint' do
    it 'gets an image info' do
      VCR.use_cassette('laos_image_data') do
        all_data = ImageService.get_images('laos')

        expect(all_data).to be_a(Hash)
      end
    end
  end
end