class AddEditedToShoutbox < ActiveRecord::Migration
  def change
    add_column :shoutboxes, :edited_at, :datetime
  end
end
