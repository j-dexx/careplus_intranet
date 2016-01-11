class AddActiveToUser < ActiveRecord::Migration
  def change
    add_column :users, :active_user, :boolean
  end
end
