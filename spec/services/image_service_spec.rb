require 'rails_helper'

RSpec.describe ImageService do
  describe 'API endpoint' do
    it 'gets an image info' do
      VCR.use_cassette('laos_image_data') do
        all_data = ImageService.get_images('laos')
        results_data = all_data[:results]

        expect(all_data).to be_a(Hash)
        expect(all_data).to have_key(:total)
        expect(results_data).to be_a(Array)
        expect(results_data.count).to eq(10)

        results_data.each do |image|
          expect(image[:alt_description]).to be_a(String)
          expect(image).to be_a(Hash)
          expect(image[:id]).to be_a(String)
          expect(image).to have_key(:urls)
          expect(image[:urls][:raw]).to be_a(String)
        end
      end
    end
  end
end