class Category < ActiveRecord::Base
  has_and_belongs_to_many :businesses

  validates :name, uniqueness: true
  default_scope  { order(:name => :asc) }
end
