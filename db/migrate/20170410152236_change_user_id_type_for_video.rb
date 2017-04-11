class ChangeUserIdTypeForVideo < ActiveRecord::Migration[5.0]
  def change
    change_column :videos, :user_id, :integer
  end
end
