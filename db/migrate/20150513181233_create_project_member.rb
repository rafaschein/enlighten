class CreateProjectMember < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.belongs_to :project, index: true
      t.belongs_to :person, index: true
    end
  end
end
