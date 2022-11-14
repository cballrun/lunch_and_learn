require 'rails_helper'

RSpec.describe TouristSightFacade do

  it 'gets tourist sight data and creates tourist sight objects' do
    VCR.use_cassette('place_service_sight_data', :allow_playback_repeats => true) do
      VCR.use_cassette('paris_facade_sight_data') do
      sights = TouristSightFacade.get_tourist_sights("france")
    
      expect(sights).to be_a(Array)
     
      sights.each do |sight|
        expect(sight).to be_a(TouristSight)
        expect(sight.id).to eq(nil)
        expect(sight.address).to be_a(String)
        expect(sight.name).to be_a(String)
        expect(sight.place_id).to be_a(String)
      end
    end
    end
  end

  # it 'returns an empty array if no images are found' do
  #   VCR.use_cassette('random_string_image') do

  #     images = ImageFacade.get_images("98asdsa7gghsdfaq55daqwrff")

  #     expect(images).to eq([])
  #   end
  # end
end