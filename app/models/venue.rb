class Venue < ActiveRecord::Base
  belongs_to :event
  validates :seatgeek_id, uniqueness: true
end
