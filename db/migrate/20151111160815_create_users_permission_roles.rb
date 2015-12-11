class CreateUsersPermissionRoles < ActiveRecord::Migration
  def change
    create_table :users_permission_roles, { id: false } do |t|
      t.references :user, index: true, foreign_key: true
      t.references :permission_role, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :users_permission_roles, [:user_id, :permission_role_id], unique: true
  end
end
