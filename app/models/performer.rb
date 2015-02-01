class Performer < ActiveRecord::Base
  has_and_belongs_to_many :events
  validates :seatgeek_id, uniqueness: true
end
