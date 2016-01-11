class CreateAwardSuggestedNominations < ActiveRecord::Migration
  def change
    create_table :award_suggested_nominations do |t|
      t.belongs_to :award
      t.belongs_to :user_nominated
      t.belongs_to :user_nominated_by

      t.timestamps
    end
    add_index :award_suggested_nominations, :award_id
    add_index :award_suggested_nominations, :user_nominated_id
    add_index :award_suggested_nominations, :user_nominated_by_id
  end
end
