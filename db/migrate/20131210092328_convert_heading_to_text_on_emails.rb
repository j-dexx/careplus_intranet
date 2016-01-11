class ConvertHeadingToTextOnEmails < ActiveRecord::Migration
  def up
    change_column :emails, :heading, :text
  end

  def down
    change_column :emails, :heading, :string
  end
end
