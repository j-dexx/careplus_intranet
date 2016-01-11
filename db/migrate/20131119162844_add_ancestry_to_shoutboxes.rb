class AddAncestryToShoutboxes < ActiveRecord::Migration
  def up
    add_column :shoutboxes, :ancestry, :string
    add_index :shoutboxes, :ancestry 
  end
  
  def down
    remove_index :shoutboxes, :ancestry
  end
  
end
