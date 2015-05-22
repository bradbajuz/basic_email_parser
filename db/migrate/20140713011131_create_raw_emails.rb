class CreateRawEmails < ActiveRecord::Migration
  def change
    create_table :raw_emails do |t|
      t.text :raw_email

      t.timestamps
    end
  end
end
