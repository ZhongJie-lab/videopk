class Myasset::BattlesController < ApplicationController
  before_action :authenticate_user!

  layout "myasset"

  def index
    @battles = Battle.where(user_id: current_user.id)
  end

  def show
    @battle = Battle.find(params[:id])
    @left_video = Video.find(@battle.left_video_id)
    @right_video = Video.find(@battle.right_video_id)

    @left_followers = FavorLeftVideoRelationship.where(battle_id: @battle.id)
    @right_followers = FavorRightVideoRelationship.where(battle_id: @battle.id)
  end

  def new
    @battle = Battle.new
    @videos = Video.all.map { |v| [v.title, v.id] }
    @myvideos = Video.where(user_id: current_user.id).map { |v| [v.title, v.id] }
  end

  def create
    @battle = Battle.create(battle_params)
    @battle.user = current_user

    if @battle.save
      redirect_to myasset_battles_path, notice: '比赛已创建!'
    else
      render :new
    end
  end
  
    def challenge_left
      @video = Video.new
      @challenge_battle = Battle.find(params[:battle_id])
      @challenge_video = Video.find(@challenge_battle.left_video_id)
    end
    
    def challenge_right
      @video = Video.new
      @challenge_battle = Battle.find(params[:battle_id])
      @challenge_video = Video.find(@challenge_battle.right_video_id)
    end
    
    def createChallenge_left
    
      battle = Battle.find(params[:battle_id])
      targetVideo = battle.left_video_id
      
      @video = Video.create(video_params)
      @video.user = current_user
      if @video.save!
        if targetVideo
          newBattle = Battle.new
          newBattle.title = battle.title
          newBattle.left_video_id = @video.id
          newBattle.right_video_id = targetVideo
          newBattle.user = current_user
          newBattle.save
          redirect_to myasset_battles_path, notice: '比赛已创建!'
        else
          redirect_to myasset_videos_path, notice: '视频已创建!'
        end
      else
        render :new
      end
    end
    def createChallenge_right
      

      battle = Battle.find(params[:battle_id])
      targetVideo = battle.right_video_id
      
      @video = Video.create(video_params)
      @video.user = current_user
      if @video.save!
        if targetVideo
          newBattle = Battle.new
          newBattle.title = battle.title
          newBattle.left_video_id = @video.id
          newBattle.right_video_id = targetVideo
          newBattle.user = current_user
          newBattle.save
          redirect_to myasset_battles_path, notice: '比赛已创建!'
        else
          redirect_to myasset_videos_path, notice: '视频已创建!'
        end
      else
        render :new
      end
    end
  def edit
    @battle = Battle.find(params[:id])
    @videos = Video.all.map { |v| [v.title, v.id] }
    @myvideos = Video.where(user_id: current_user.id).map { |v| [v.title, v.id] }
  end

  def update
    @battle = Battle.find(params[:id])

    if @battle.update(battle_params)
      redirect_to myasset_battles_path, notice: '比赛已更新!'
    else
      render :edit
    end
  end

  def destroy
    @battle = Battle.find(params[:id])
    @battle.destroy

    redirect_to myasset_battles_path,  alert: '比赛已被删除！'
  end

  private
  def battle_params
    params.require(:battle).permit(:title, :description, :left_video_id, :right_video_id)
  end
    def video_params
      params.require(:video).permit(:title, :description, :video, :image)
    end
end
