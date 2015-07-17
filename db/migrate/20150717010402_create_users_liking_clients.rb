class CreateUsersLikingClients < ActiveRecord::Migration
  def change
    create_table :users_liking_clients, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.timestamps
    end

    add_index :users_liking_clients, [:user_id, :client_id], unique: true
  end
end
