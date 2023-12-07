# == Schema Information
#
# Table name: session_suggestions
#
#  id               :integer          not null, primary key
#  recommended_time :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  busy_time_id     :integer          not null
#  place_id         :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_session_suggestions_on_busy_time_id  (busy_time_id)
#  index_session_suggestions_on_place_id      (place_id)
#  index_session_suggestions_on_user_id       (user_id)
#
# Foreign Keys
#
#  busy_time_id  (busy_time_id => busy_times.id)
#  place_id      (place_id => places.id)
#  user_id       (user_id => users.id)
#
class SessionSuggestion < ApplicationRecord
  belongs_to :user
  belongs_to :place

  # Add other necessary validations and callbacks as needed

  def calculate_recommended_time
    # Get the busyness levels for the associated place
    busyness_levels = place.busy_times.pluck(:busyness_level)

    # Get the user's preferred time range
    preferred_start_hour = user.preferred_times.minimum(:start_hour)
    preferred_end_hour = user.preferred_times.maximum(:end_hour)

    # Get the user's calendar times for the current day
    user_calendar_times = user.calendar_times.where(day_of_week: Date.today.wday)

    # Create an array to store the busyness levels for each hour within the user's preferred time range
    busyness_levels_within_preference = []

    # Iterate over each hour in the user's preferred time range
    (preferred_start_hour..preferred_end_hour).each do |hour|
      # Check if the user has a calendar time for the current hour
      unless user_calendar_times.exists?(start_hour: hour)
        # If not, add the busyness level for the current hour to the array
        busyness_levels_within_preference.push(busyness_levels[hour - 1])
      end
    end

    # Find the hour with the minimum busyness level within the user's preferred time range
    recommended_hour = preferred_start_hour + busyness_levels_within_preference.index(busyness_levels_within_preference.min)

    # Update the recommended_time attribute with the calculated time
    update(recommended_time: recommended_hour)
  end
end
