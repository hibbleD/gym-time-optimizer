class CreateCalendarTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_times do |t|
      t.references :user, null: false, foreign_key: true
      t.string :day_of_week
      t.integer :start_hour
      t.integer :end_hour

      t.timestamps
    end
  end
end
