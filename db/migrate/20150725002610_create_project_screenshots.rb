class CreateProjectScreenshots < ActiveRecord::Migration
  def change
    create_table :project_screenshots do |t|
      t.references :project, index: true, foreign_key: true
      t.text :description
      t.string :image_id

      t.timestamps null: false
    end
  end
end
