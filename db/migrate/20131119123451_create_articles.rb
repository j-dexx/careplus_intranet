class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :headline
      t.text :summary
      t.text :content
      t.date :date
      t.string :image
      t.boolean :display

      t.timestamps
    end
  end
end
