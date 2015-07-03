class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :activity_owner, polymorphic: true, index: true
      t.references :item, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
