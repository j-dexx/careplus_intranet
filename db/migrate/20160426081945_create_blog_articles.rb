class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.belongs_to :blog_author
      t.string :title, null: false
      t.text :summary
      t.text :content, null: false
      t.string :image
      t.date :date_published, null: false
      t.boolean :display, default: true
      t.string :slug

      t.timestamps
    end
    add_index :blog_articles, :blog_author_id
  end
end
