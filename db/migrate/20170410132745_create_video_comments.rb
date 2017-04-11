class CreateVideoComments < ActiveRecord::Migration[5.0]
  def change
    create_table :video_comments do |t|
      t.integer :video_id
      t.integer :user_id
      t.text    :comment
      t.timestamps
    end
  end
end
