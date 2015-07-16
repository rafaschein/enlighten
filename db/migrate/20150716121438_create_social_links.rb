class CreateSocialLinks < ActiveRecord::Migration
  def change
    create_table :social_links do |t|
      t.references :person, index: true, foreign_key: true
      t.string :provider
      t.string :indentifier

      t.timestamps null: false
    end
  end
end
