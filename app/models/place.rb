# == Schema Information
#
# Table name: places
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  google_place_id :integer
#
class Place < ApplicationRecord
  has_many :busy_times
end
