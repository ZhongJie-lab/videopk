module BattlesHelper
  def render_left_width(battle)
    (battle.left_followers.count + battle.visitor_votes.where(voteLeft: true).count).to_f/total_votes(battle).to_f*100
  end

  def render_right_width(battle)
    (battle.right_followers.count + battle.visitor_votes.where(voteLeft: false).count).to_f/total_votes(battle).to_f*100
  end

   def total_votes(battle)
     left_votes(battle) + right_votes(battle)
   end
   
   def left_votes(battle)
      battle.left_followers.count + battle.visitor_votes.where(voteLeft: true).count
   end
   def right_votes(battle)
      battle.right_followers.count + battle.visitor_votes.where(voteLeft: false).count
   end
  def right_is_voted(battle)
    if current_user
      current_user.has_follow_right?(battle)
    else
      visitorID = find_visitor_id
      battle.visitor_votes.find_by(visitorID:visitorID, voteLeft:false) != nil
    end
  end  
  def left_is_voted(battle)
    if current_user
      current_user.has_follow_left?(battle)
    else
      visitorID = find_visitor_id
      battle.visitor_votes.find_by(visitorID:visitorID, voteLeft:true) != nil
    end
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
