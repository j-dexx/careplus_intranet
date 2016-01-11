class CreateAwardVotes < ActiveRecord::Migration
  def change
    create_table :award_votes do |t|
      t.belongs_to :award
      t.belongs_to :nomination
      t.belongs_to :user

      t.timestamps
    end
    add_index :award_votes, :award_id
    add_index :award_votes, :nomination_id
    add_index :award_votes, :user_id
  end
end
