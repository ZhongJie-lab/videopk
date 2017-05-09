class Admin::BattlesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  layout "admin"

  def index
    @battles = Battle.all
    @battles_waiting_prove = Battle.all.where(is_hidden: true)
    @battles_proved        = Battle.all.where(is_hidden: false)
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
  end

  def create
    @battle = Battle.create(battle_params)
    @battle.user = current_user

    if @battle.save
      redirect_to admin_battles_path, notice: '比赛已创建!'
    else
      render :new
    end
  end

  def edit
    @battle = Battle.find(params[:id])
    @videos = Video.all.map { |v| [v.title, v.id] }
  end

  def update
    @battle = Battle.find(params[:id])

    if @battle.update(battle_params)
      redirect_to admin_battles_path, notice: '比赛已更新!'
    else
      render :edit
    end
  end

  def destroy
    @battle = Battle.find(params[:id])
    @battle.destroy

    redirect_to admin_battles_path,  alert: '比赛已删除!'
  end

  def publish
    @battle = Battle.find(params[:id])
    @battle.publish!
    redirect_to :back
  end

  def hidden
    @battle = Battle.find(params[:id])
    @battle.hide!
    redirect_to :back
  end

  private
  def battle_params
    params.require(:battle).permit(:title, :description, :left_video_id, :right_video_id)
  end
end
