class AddImageToPerson < ActiveRecord::Migration
  def change
    add_column :people, :image_id, :string
  end
end
