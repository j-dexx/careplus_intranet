class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :address
      t.string :postcode
      t.string :image
      t.boolean :display

      t.timestamps
    end
  end
end
