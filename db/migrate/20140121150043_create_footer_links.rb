class CreateFooterLinks < ActiveRecord::Migration
  def change
    create_table :footer_links do |t|
      t.integer :position
      t.string :title
      t.string :link
      t.boolean :display

      t.timestamps
    end
  end
end
