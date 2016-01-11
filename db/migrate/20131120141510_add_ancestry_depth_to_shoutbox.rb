class AddAncestryDepthToShoutbox < ActiveRecord::Migration
  def change
    add_column :shoutboxes, :ancestry_depth, :integer
  end
end
