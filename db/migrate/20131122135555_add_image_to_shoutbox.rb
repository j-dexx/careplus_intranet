class AddImageToShoutbox < ActiveRecord::Migration
  def change
    add_column :shoutboxes, :image, :string
    add_column :shoutboxes, :sale_item, :boolean
  end
end
