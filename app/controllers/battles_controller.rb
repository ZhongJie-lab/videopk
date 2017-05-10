class BattlesController < ApplicationController
  before_action :authenticate_user!, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video]

  before_action :find_battle, only: [:follow_left_video, :unfollow_left_video, :follow_right_video, :unfollow_right_video, :vote_for_left, :vote_for_right]

  def index
    #@battle = Battle.published.recent.first
    @battles = Battle.published.recent #.paginate(:page => params[:page], :per_page => 3)


    # if @battle.present?
    # @left_video = Video.find(@battle.left_video_id)
    # @right_video = Video.find(@battle.right_video_id)

    # @left_video_comments = VideoComment.where(video_id: @battle.left_video_id).order("created_at DESC")
    # @left_video_comment = VideoComment.new
    #
    # @right_video_comments = VideoComment.where(video_id: @battle.right_video_id).order("created_at DESC")
    # @right_video_comment = VideoComment.new

    #@battle_comments = BattleComment.where(battle_id: @battle.id)
    @battle_comment = BattleComment.new
    #end
  end
  def show
    @battle = Battle.find(params[:id])
    @title = @battle.title
    
  end
  def follow_left_video
    if current_user.has_follow_right?(@battle)
      flash[:warning] = "已经给右边视频投票！不能同时投两边！" if request.format.html?
    else
    flash[:warning] = "投票成功" if request.format.html?
      current_user.follow_left!(@battle)
    end
    redirect_to :back
  end

  def unfollow_left_video
    current_user.unfollow_left!(@battle)
    redirect_to :back
  end

  def follow_right_video
    if current_user.has_follow_left?(@battle)
      flash[:warning] = "已经给左边视频投票！不能同时投两边！" if request.format.html?
    else
    flash[:warning] = "投票成功" if request.format.html?
      current_user.follow_right!(@battle)
    end
    redirect_to :back
  end

  def unfollow_right_video
    current_user.unfollow_right!(@battle)
    redirect_to :back
  end
  
  def vote_for_left
    if current_user
      if current_user.has_follow_right?(@battle)

        flash[:warning] = "已经投了右边" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
        return
      end
      
      if current_user.has_follow_left?(@battle)
        flash[:warning] = "不能再投了" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
        return
      end
      
      current_user.follow_left!(@battle)
      flash[:warning] = "投票成功" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
    else
      #visitor click left vote button
      visitorID = find_visitor_id
      visitorVoteForTheBattle = @battle.visitor_votes.find_by(visitorID:visitorID)
      if visitorVoteForTheBattle
        if visitorVoteForTheBattle.voteLeft
          flash[:warning] = "不能再投了" if request.format.html?
        else
          flash[:warning] = "已经投了右边"  if request.format.html?
        end
      else
        newVote = @battle.visitor_votes.build(visitorID:visitorID,voteLeft:true)
        flash[:warning] = "投票成功" if request.format.html?
        newVote.save
      end
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end
  
  def vote_for_right
    if current_user
      if current_user.has_follow_left?(@battle)
        flash[:warning] = "已经投了左边" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
        return
      end
      
      if current_user.has_follow_right?(@battle)
        flash[:warning] = "不能再投了" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
        return
      end
      
      current_user.follow_right!(@battle)
      flash[:warning] = "投票成功" if request.format.html?
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
    else
      #visitor click left vote button
      visitorID = find_visitor_id
      visitorVoteForTheBattle = @battle.visitor_votes.find_by(visitorID:visitorID)
      if visitorVoteForTheBattle
        if visitorVoteForTheBattle.voteLeft == false
          flash[:warning] = "不能再投了" if request.format.html?
        else
          flash[:warning] = "已经投了左边" if request.format.html?
        end
      else
        newVote = @battle.visitor_votes.build(visitorID:visitorID,voteLeft:false)
        flash[:warning] = "投票成功" if request.format.html?
        newVote.save
      end
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end
  def about
  end

  def contact
  end
  private
  def find_battle
    @battle = Battle.find(params[:id])
  end
  def find_visitor_id
    visitorID = ""
    if(visitor_id_incookie = cookies.signed[:visitorID])
      visitorID = visitor_id_incookie
    else
      visitorID = Time.now.to_s
      cookies.permanent.signed[:visitorID] = visitorID
    end
    visitorID
  end

end
