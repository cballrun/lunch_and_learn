class Api::V1::LearningResourcesController < ApplicationController

  def index 
    if params[:country] && params[:country].length > 0
      video = VideoFacade.get_a_video(params[:country])
      images = ImageFacade.get_images(params[:country])
      learning_resource = LearningResource.new(video, images, params[:country])
      render json: LearningResourceSerializer.new(learning_resource)
    else
      pseudo_resource = LearningResource.new([], [], "Invalid search")
      render json: LearningResourceSerializer.new(pseudo_resource)
    end
  end
end
