class CreateRole < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.text :description
    end
  end
end
