class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages  do |t|
      t.string :layout
      t.string :style
      t.string :title
      t.string :image
      t.text :content
      t.string :slug
      t.boolean :display, :default => true

      t.timestamps
    end
    add_index :pages, :slug, :unique => true
  end
  
  def down
    drop_table :pages
  end
end
