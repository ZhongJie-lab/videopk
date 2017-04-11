class Admin::VideosController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_required

    layout "admin"

    def index
      @videos = Video.all

    end

    def show
      @video = Video.find(params[:id])
    end

    def new
      @video = Video.new
    end

    def create
      @video = Video.create(video_params)
      @video.user = current_user

      if @video.save
        redirect_to admin_videos_path, notice: 'Video Created!'
      else
        render :new
      end
    end

    def edit
      @video = Video.find(params[:id])
    end

    def update
      @video = Video.find(params[:id])

      if @video.update(video_params)
        redirect_to admin_videos_path, notice: 'Video updated!'
      else
        render :edit
      end
    end

    def destroy
      @video = Video.find(params[:id])
      @video.destroy
      redirect_to admin_videos_path, alert: 'Video deleted'
    end

    private
    def video_params
      params.require(:video).permit(:title, :description, :video, :image)
    end
end
