class CreateUsersLikingProjects < ActiveRecord::Migration
  def change
    create_table :users_liking_projects, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.timestamps
    end

    add_index :users_liking_projects, [:user_id, :project_id], unique: true
  end
end
