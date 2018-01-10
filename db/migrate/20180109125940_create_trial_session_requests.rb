class CreateTrialSessionRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :trial_session_requests do |t|
      t.datetime :datetime
      t.string :time_zone
      t.string :customer_name
      t.string :customer_company
      t.string :customer_email
      t.string :url
      t.text :message
      t.string :how_found_us
      t.text :notes
      t.boolean :agree_to_terms_and_conditions
      t.integer :lock_version

      t.timestamps
    end
  end
end
