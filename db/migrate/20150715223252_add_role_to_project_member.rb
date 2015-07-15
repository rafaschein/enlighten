class AddRoleToProjectMember < ActiveRecord::Migration
  def change
    add_reference :project_members, :role, index: true, foreign_key: true
  end
end
