# This migration comes from spree_easy_homepage (originally 20191228110047)
class CreateSpreeHomeSection < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_home_sections do |t|
      t.string :title
      t.integer :position, index: true

      t.timestamps
    end
  end
end
