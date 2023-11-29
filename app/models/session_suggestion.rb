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
  belongs_to :busy_time
end
