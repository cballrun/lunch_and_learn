class VideoFacade
  
  def self.get_a_video(country)
    all_video_data = VideoService.get_a_video(country)
    needed_video_data = all_video_data[:items].first
    Video.new(needed_video_data)
  end
end