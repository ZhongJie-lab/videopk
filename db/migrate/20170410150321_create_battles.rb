class CreateBattles < ActiveRecord::Migration[5.0]
  def change
    create_table :battles do |t|
      t.string        :title
      t.text          :description
      t.integer       :left_video_id
      t.integer       :right_video_id
      t.timestamps
    end
  end
end
