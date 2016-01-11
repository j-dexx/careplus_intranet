class AddSuggestedNominationIdToAwardNomination < ActiveRecord::Migration
  def change
    add_column :award_nominations, :award_suggested_nomination_id, :integer
    add_index :award_nominations, :award_suggested_nomination_id
  end
end
