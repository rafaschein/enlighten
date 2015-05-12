class AddImageToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :image_id, :string
  end
end
