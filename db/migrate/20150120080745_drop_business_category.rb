class DropBusinessCategory < ActiveRecord::Migration
  def up
    drop_table :businesscategories
  end

  def down
    create_table :businesscategories do |t|
      t.string :name
      t.string :alias
      t.references :business

      t.timestamps
    end
    add_index :businesscategories, :business_id
  end
end
