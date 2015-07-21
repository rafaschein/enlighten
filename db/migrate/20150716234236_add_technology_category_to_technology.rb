class AddTechnologyCategoryToTechnology < ActiveRecord::Migration
  def change
    add_reference :technologies, :technology_category, index: true, foreign_key: true
  end
end
