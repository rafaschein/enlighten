class CreateUserFollowedTechnologies < ActiveRecord::Migration
  def change
    create_table :user_followed_technologies, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :technology, index: true, foreign_key: true
      t.timestamps
    end

    add_index :user_followed_technologies, [:user_id, :technology_id], unique: true
  end
end
