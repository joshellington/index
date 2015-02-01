class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :url
      t.string :datetime_local
      t.string :short_title
      t.string :datetime_utc
      t.integer :score
      t.string :type
      t.integer :seatgeek_id

      t.timestamps
    end
  end
end
