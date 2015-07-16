class FixSocialLinkColumnName < ActiveRecord::Migration
  def change
    rename_column :social_links, :indentifier, :identifier
  end
end
