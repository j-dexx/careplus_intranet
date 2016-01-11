class CreateShoutboxes < ActiveRecord::Migration
  def change
    create_table :shoutboxes do |t|
      t.string :title
      t.text :message
      t.belongs_to :shout
      t.belongs_to :user
      t.boolean :reported
      t.boolean :display
      t.datetime :created

      t.timestamps
    end
    add_index :shoutboxes, :shout_id
    add_index :shoutboxes, :user_id
  end
end
