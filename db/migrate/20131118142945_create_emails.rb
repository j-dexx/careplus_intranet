class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :template
      t.string :subject
      t.string :heading
      t.text :summary
      t.text :content
      t.string :image
      t.string :image_alt
      t.string :campaign_id
      t.boolean :campaign_sent, :default => false
      t.string :list_id
      t.string :list_name

      t.timestamps
    end
  end
end
