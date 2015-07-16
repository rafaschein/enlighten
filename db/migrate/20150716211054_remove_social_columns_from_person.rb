class RemoveSocialColumnsFromPerson < ActiveRecord::Migration
  def change
    remove_column :people, :github_account, :string
    remove_column :people, :twitter_account, :string
  end
end
