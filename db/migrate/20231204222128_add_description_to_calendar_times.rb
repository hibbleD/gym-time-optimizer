class AddDescriptionToCalendarTimes < ActiveRecord::Migration[7.0]
  def change
    add_column :calendar_times, :description, :text
  end
end
