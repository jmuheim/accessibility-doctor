class CreateTrialSessionRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :trial_session_requests do |t|
      t.datetime :starts_at
      t.text :availability
      t.string :time_zone
      t.string :language
      t.string :name
      t.string :company
      t.string :email
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
