class AddItemSoldToShoutboxes < ActiveRecord::Migration
  def change
    add_column :shoutboxes, :item_sold, :boolean
  end
end
