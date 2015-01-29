json.extract! @business, :id, :name, :image_url, :url, :mobile_url, :phone, :display_phone, :review_count, :rating, :rating_img_url_large, :snippet_text, :address, :display_address, :city, :state_code, :postal_code, :country_code, :cross_streets, :is_claimed, :created_at, :updated_at, :parking_spaces, :lat, :lng

json.neighborhoods @business.neighborhoods
json.categories @business.categories
json.parking_options @business.parking_options