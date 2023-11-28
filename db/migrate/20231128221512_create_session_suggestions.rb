class CreateSessionSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :session_suggestions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.integer :recommended_time
      t.references :busy_time, null: false, foreign_key: true

      t.timestamps
    end
  end
end
