class AddImageToVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :image, :string
  end
end
