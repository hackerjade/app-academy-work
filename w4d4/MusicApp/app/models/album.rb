# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string
#  band_id    :integer
#  album_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  belongs_to(:band)
  has_many(:tracks, dependent: :destroy)

  validates :name, :band_id, presence: true

end
