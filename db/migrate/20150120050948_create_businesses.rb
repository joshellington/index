class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :image_url
      t.string :url
      t.string :mobile_url
      t.string :phone
      t.string :display_phone
      t.string :review_count
      t.integer :rating
      t.string :rating_img_url_large
      t.string :snippet_text
      t.string :address
      t.string :display_address
      t.string :city
      t.string :state_code
      t.string :postal_code
      t.string :country_code
      t.string :cross_streets
      t.boolean :is_claimed

      t.timestamps
    end
  end
end
