class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.text :headline
      t.string :image
      t.string :link
      t.boolean :display

      t.timestamps
    end
  end
end
