class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :position
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :image
      t.text :biography
      t.boolean :display

      t.timestamps
    end
  end
end
