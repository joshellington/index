class Business < ActiveRecord::Base
  reverse_geocoded_by :lat, :lng
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :neighborhoods
  has_and_belongs_to_many :parking_options

  validates :yelp_id, uniqueness: true
  default_scope  { order(:name => :asc) }
  self.per_page = 100

  search_syntax do
    search_by :text do |scope, phrases|
      columns = [:name, :address, :url]
      scope.where_like(columns => phrases)
    end
  end
end
