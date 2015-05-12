class AddImageToClient < ActiveRecord::Migration
  def change
    add_column :clients, :image_id, :string
  end
end
