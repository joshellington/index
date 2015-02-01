class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.string :name
      t.string :short_name
      t.string :url
      t.string :image
      t.string :image_large
      t.string :image_huge
      t.integer :seatgeek_id
      t.string :score
      t.string :type
      t.string :slug

      t.timestamps
    end
  end
end
