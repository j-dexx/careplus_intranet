class AddReasonToAwardSuggestedNomination < ActiveRecord::Migration
  def change
    add_column :award_suggested_nominations, :reason, :text
  end
end
