class Business < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :neighborhoods
  has_and_belongs_to_many :parking_options

  validates :yelp_id, uniqueness: true
  default_scope  { order(:name => :asc) }
end
