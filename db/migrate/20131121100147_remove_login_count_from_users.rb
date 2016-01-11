class RemoveLoginCountFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :login_count
  end

  def down
    dd_column :users, :login_count, :integer
  end
end
