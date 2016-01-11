class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :job_title
      t.string :department
      t.text :profile
      t.string :phone_number
      t.integer :login_count
      t.string :password_digest
      t.string :auth_token
      t.string :photo

      t.timestamps
    end
  end
end
