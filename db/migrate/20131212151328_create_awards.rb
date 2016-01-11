class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :title
      t.string :image
      t.text :description
      t.string :mode
      t.belongs_to :user
      t.boolean :display
      t.integer :position

      t.timestamps
    end
    add_index :awards, :user_id
  end
end
