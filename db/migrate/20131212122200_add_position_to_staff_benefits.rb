class AddPositionToStaffBenefits < ActiveRecord::Migration
  def change
    add_column :staff_benefits, :position, :integer
  end
end
