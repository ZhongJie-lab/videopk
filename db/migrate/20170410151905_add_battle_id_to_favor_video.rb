class AddBattleIdToFavorVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :favor_video_relationships, :battle_id, :integer
  end
end
