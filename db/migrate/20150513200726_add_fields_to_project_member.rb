class AddFieldsToProjectMember < ActiveRecord::Migration
  def change
    add_column :project_members, :period_start, :date
    add_column :project_members, :period_end, :date
    add_column :project_members, :function, :string
  end
end
