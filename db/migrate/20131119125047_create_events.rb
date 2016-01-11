class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.text :summary
      t.text :content
      t.string :image
      t.boolean :display

      t.timestamps
    end
  end
end
