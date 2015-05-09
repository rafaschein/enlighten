class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :scm_type
      t.string :scm_reference

      t.timestamps null: false
    end
  end
end
