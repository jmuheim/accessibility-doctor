class CreateTrialSessionRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :trial_session_requests do |t|
      t.datetime :datetime
      t.integer :duration
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