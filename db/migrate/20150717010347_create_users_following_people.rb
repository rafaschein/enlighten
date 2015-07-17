class CreateUsersFollowingPeople < ActiveRecord::Migration
  def change
    create_table :users_following_people, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.timestamps
    end

    add_index :users_following_people, [:user_id, :person_id], unique: true
  end
end
