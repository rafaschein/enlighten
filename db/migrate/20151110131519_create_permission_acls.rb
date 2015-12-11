class CreatePermissionAcls < ActiveRecord::Migration
  def change
    create_table :permission_acls do |t|
      t.string :model
      t.string :action
      t.belongs_to :permission_role, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
