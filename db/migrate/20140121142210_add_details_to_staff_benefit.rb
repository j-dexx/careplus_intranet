class AddDetailsToStaffBenefit < ActiveRecord::Migration
  def change
    add_column :staff_benefits, :details, :text
    remove_column :staff_benefits, :link
  end
end
