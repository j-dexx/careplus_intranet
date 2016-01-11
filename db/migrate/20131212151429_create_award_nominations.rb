class CreateAwardNominations < ActiveRecord::Migration
  def change
    create_table :award_nominations do |t|
      t.belongs_to :award
      t.belongs_to :user

      t.timestamps
    end
    add_index :award_nominations, :award_id
    add_index :award_nominations, :user_id
  end
end
