class AddRumourToShoutbox < ActiveRecord::Migration
  def change
    add_column :shoutboxes, :rumour, :boolean
  end
end
