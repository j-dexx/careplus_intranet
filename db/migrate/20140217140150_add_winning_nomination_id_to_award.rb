class AddWinningNominationIdToAward < ActiveRecord::Migration
  def change
    add_column :awards, :award_suggested_nomination_id, :integer
    add_index :awards, :award_suggested_nomination_id
    remove_column :awards, :user_id
  end
end
