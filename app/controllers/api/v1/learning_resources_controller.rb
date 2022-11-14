class Api::V1::LearningResourcesController < ApplicationController

  def index 
    video = VideoFacade.get_a_video(params[:country])
    images = ImageFacade.get_images(params[:country])
    learning_resource = LearningResource.new(video, images, params[:country])
    render json: LearningResourceSerializer.new(learning_resource)
  end
end
