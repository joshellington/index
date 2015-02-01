class Event < ActiveRecord::Base
  has_one :venue
  has_and_belongs_to_many :performers

  validates :seatgeek_id, uniqueness: true
end
