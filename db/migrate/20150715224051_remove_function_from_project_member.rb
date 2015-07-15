class RemoveFunctionFromProjectMember < ActiveRecord::Migration
  def change
    remove_column :project_members, :function, :string
  end
end
