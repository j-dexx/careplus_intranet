class AddGroupToMember < ActiveRecord::Migration
  def change
    add_column :members, :group, :integer
  end
end
