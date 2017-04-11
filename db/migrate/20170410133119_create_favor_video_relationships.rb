class CreateFavorVideoRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :favor_video_relationships do |t|
      t.integer :video_id
      t.integer :user_id
      t.timestamps
    end
  end
end
