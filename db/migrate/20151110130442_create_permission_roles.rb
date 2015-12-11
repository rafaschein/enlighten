class CreatePermissionRoles < ActiveRecord::Migration
  def change
    create_table :permission_roles do |t|
      t.string :name
      t.boolean :default, default: false

      t.timestamps null: false
    end
  end
end
