class CreateUserLikedProjects < ActiveRecord::Migration
  def change
    create_table :user_liked_projects, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.timestamps
    end

    add_index :user_liked_projects, [:user_id, :project_id], unique: true
  end
end
