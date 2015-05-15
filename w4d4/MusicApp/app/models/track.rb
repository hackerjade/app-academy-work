# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string
#  album_id   :integer
#  track_type :string
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to(:albums)
  has_many(:notes)

  validates :name, :album_id, :track_type, :lyrics, presence: true

end
