class CreateSaleCategories < ActiveRecord::Migration
  def change
    create_table :sale_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
