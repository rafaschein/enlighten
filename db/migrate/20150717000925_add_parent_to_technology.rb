class AddParentToTechnology < ActiveRecord::Migration
  def change
    add_reference :technologies, :parent, index: true
  end
end
