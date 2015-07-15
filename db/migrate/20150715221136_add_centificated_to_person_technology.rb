class AddCentificatedToPersonTechnology < ActiveRecord::Migration
  def change
    add_column :person_technologies, :certificated, :boolean
  end
end
