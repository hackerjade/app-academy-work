class Note < ActiveRecord::Base
  validates :text, presence: true
  # :user_id, :track_id,

  belongs_to(:track)
  belongs_to(:user)
end
