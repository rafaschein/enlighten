class CreatePermissionRoles < ActiveRecord::Migration
  def change
    create_table :permission_roles do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
