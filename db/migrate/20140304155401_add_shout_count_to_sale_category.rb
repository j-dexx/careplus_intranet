class AddShoutCountToSaleCategory < ActiveRecord::Migration
  def change
    add_column :sale_categories, :shoutboxes_count, :integer, :default => 0
    
    SaleCategory.reset_column_information
    SaleCategory.find_each do |u|
      SaleCategory.reset_counters u.id, :shoutboxes
    end
  end
end
