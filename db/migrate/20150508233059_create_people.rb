class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :github_account
      t.string :twitter_account

      t.timestamps null: false
    end
  end
end
