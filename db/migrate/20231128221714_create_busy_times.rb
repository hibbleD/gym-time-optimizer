class CreateBusyTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :busy_times do |t|
      t.references :place, null: false, foreign_key: true
      t.integer :day_of_week
      t.string :status
      t.integer :busy_times

      t.timestamps
    end
  end
end
