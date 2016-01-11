class AddCategoryToShoutbox < ActiveRecord::Migration
  def change
    add_column :shoutboxes, :sale_category_id, :integer
    add_index :shoutboxes, :sale_category_id
  end
end
