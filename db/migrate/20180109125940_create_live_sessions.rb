class CreateLiveSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :live_sessions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :customer_name
      t.string :customer_email
      t.string :url
      t.text :description
      t.text :notes
      t.integer :lock_version

      t.timestamps
    end
  end
end
