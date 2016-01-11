class AddStringsToAwardSuggestedNomination < ActiveRecord::Migration
  def change
    add_column :award_suggested_nominations, :name, :string
    add_column :award_suggested_nominations, :telephone, :string
    add_column :award_suggested_nominations, :email, :string
    add_column :award_suggested_nominations, :nomination_type, :string
  end
end
