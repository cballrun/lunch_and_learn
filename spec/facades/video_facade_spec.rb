require 'rails_helper'

RSpec.describe VideoFacade do
  it 'gets data for one video and creates a video object' do
    VCR.use_cassette('laos_video_data') do
      video = VideoFacade.get_a_video('laos')

      expect(video).to be_a(Video)
      expect(video.title).to be_a(String)
      expect(video.youtube_video_id).to be_a(String)
    end
  end
end