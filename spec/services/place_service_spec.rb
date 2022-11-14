require 'rails_helper'

RSpec.describe PlaceService do
  describe 'API endpoint' do

    it 'gets info about tourism sights within 20000 meter radius of a countrys capital' do
      VCR.use_cassette('place_service_sight_data',:allow_playback_repeats => true) do
        all_data = PlaceService.get_tourist_sights("france")
        all_feature_data = all_data[:features]
        one_feature_data = all_feature_data.first
        
        expect(all_data).to be_a(Hash)
        expect(all_data[:type]).to eq("FeatureCollection")
        expect(all_feature_data).to be_a(Array)
        expect(all_feature_data.last).to be_a(Hash)
        
        all_feature_data.each do |feature|
          expect(feature).to be_a(Hash)
          expect(feature[:type]).to eq("Feature")
          expect(feature[:properties][:name]).to be_a(String)
          expect(feature[:properties][:formatted]).to be_a(String)
          expect(feature[:properties][:place_id]).to be_a(String)
        end
        
      end
    end
  end
end