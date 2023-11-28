class CreatePreferredTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :preferred_times do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :start_hour
      t.integer :end_hour
      t.string :day_of_week

      t.timestamps
    end
  end
end
