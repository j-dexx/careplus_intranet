class CreateEmailItems < ActiveRecord::Migration
  def change
    create_table :email_items do |t|
      t.belongs_to :email
      t.string :email_item_type
      t.integer :email_item_id
      t.integer :position, :default => 0

      t.timestamps
    end
    add_index :email_items, :email_id
  end
end
