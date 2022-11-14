class VideoFacade
  
  def self.get_a_video(country)
    all_video_data = VideoService.get_a_video(country)
    if all_video_data[:items].count > 0
      needed_video_data = all_video_data[:items].first
      Video.new(needed_video_data)
    else
      []
    end
  end
end