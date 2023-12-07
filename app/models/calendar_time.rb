# == Schema Information
#
# Table name: calendar_times
#
#  id          :integer          not null, primary key
#  day_of_week :string
#  description :text
#  end_hour    :integer
#  start_hour  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_calendar_times_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class CalendarTime < ApplicationRecord
  belongs_to :user
end
