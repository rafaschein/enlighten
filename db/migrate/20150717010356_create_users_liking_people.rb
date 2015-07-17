class CreateUsersLikingPeople < ActiveRecord::Migration
  def change
    create_table :users_liking_people, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.timestamps
    end

    add_index :users_liking_people, [:user_id, :person_id], unique: true
  end
end
