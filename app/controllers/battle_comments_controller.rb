class BattleCommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @battle = Battle.find(params[:battle_id])
    @battle_comment = BattleComment.new
  end

  def create
    @battle_comment = BattleComment.create(battle_comment_params)
    @battle_comment.user = current_user

    battle = Battle.find(params[:battle_id])
    @battle_comment.battle = battle
    @battle_comment.save!

    redirect_to root_path
  end

  private
  def battle_comment_params
    params.require(:battle_comment).permit(:comment)
  end
end
