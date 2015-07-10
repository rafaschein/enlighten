class CreateUserLikedTechnologies < ActiveRecord::Migration
  def change
    create_table :user_liked_technologies, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :technology, index: true, foreign_key: true
      t.timestamps
    end

    add_index :user_liked_technologies, [:user_id, :technology_id], unique: true
  end
end
