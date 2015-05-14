class CreatePersonTechnology < ActiveRecord::Migration
  def change
    create_table :person_technologies do |t|
      t.belongs_to :person, index: true
      t.belongs_to :technology, index: true
      t.integer :skill_rating, default: 0, null: false
    end
  end
end
