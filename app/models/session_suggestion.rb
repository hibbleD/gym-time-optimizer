class SessionSuggestion < ApplicationRecord
  belongs_to :user
  belongs_to :place
  belongs_to :busy_time
end
