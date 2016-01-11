class AddAwardVotesCountToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :award_votes_count, :integer, :default => 0
  end
end
