class CreateStaffBenefits < ActiveRecord::Migration
  def change
    create_table :staff_benefits do |t|
      t.string :title
      t.string :image
      t.string :link
      t.boolean :display

      t.timestamps
    end
  end
end
