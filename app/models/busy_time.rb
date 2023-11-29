# == Schema Information
#
# Table name: busy_times
#
#  id          :integer          not null, primary key
#  busy_times  :integer
#  day_of_week :integer
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  place_id    :integer          not null
#
# Indexes
#
#  index_busy_times_on_place_id  (place_id)
#
# Foreign Keys
#
#  place_id  (place_id => places.id)
#
class BusyTime < ApplicationRecord
  belongs_to :place
end
