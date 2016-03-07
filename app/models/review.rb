class Review < ActiveRecord::Base
  belongs_to :artist
  belongs_to :drawing

  validates :drawing_id, uniqueness: { scope: :artist_id }
end
