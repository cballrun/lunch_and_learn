require 'rails_helper'

RSpec.describe VideoService do
  describe 'API endpoint' do
    it 'gets a video info' do
      VCR.use_cassette('laos_video_data') do
        all_data = VideoService.get_a_video('laos')
        video_data = all_data[:items].first

        expect(all_data).to be_a(Hash)
        expect(all_data[:items]).to be_a(Array)
        expect(all_data[:items].count).to eq(1)
        
        expect(video_data).to be_a(Hash)
       
        expect(video_data[:id]).to be_a(Hash)
        expect(video_data[:id].keys.count).to eq(2)
        expect(video_data[:id][:videoId]).to be_a(String)

        expect(video_data[:snippet]).to be_a(Hash)
        expect(video_data[:snippet].keys.count).to eq(8)
        expect(video_data[:snippet][:title]).to be_a(String)
      end
    end
  end
end