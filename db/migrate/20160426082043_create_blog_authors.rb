class CreateBlogAuthors < ActiveRecord::Migration
  def change
    create_table :blog_authors do |t|
      t.string :name, null: false
      t.string :slug
      t.string :image
      t.text :bio
      t.boolean :display, default: true
      t.boolean :chief_executive, default: false

      t.timestamps
    end
  end
end
