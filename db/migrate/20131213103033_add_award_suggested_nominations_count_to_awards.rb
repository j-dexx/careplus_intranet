class AddAwardSuggestedNominationsCountToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :award_suggested_nominations_count, :integer, :default => 0
  end
end
