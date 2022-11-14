class LearningResource
  attr_reader :id,
              :video,
              :images,
              :country

  def initialize(video, images, country)
    @id = nil
    @video = video
    @images = images
    @country = country
  end
end