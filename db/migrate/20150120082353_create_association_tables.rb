class CreateAssociationTables < ActiveRecord::Migration
  def change
    create_table :businesses_parking_options do |t|
      t.belongs_to :business, index: true
      t.belongs_to :parking_option, index: true
    end

    create_table :businesses_neighborhoods do |t|
      t.belongs_to :business, index: true
      t.belongs_to :neighborhood, index: true
    end

    create_table :businesses_categories do |t|
      t.belongs_to :business, index: true
      t.belongs_to :category, index: true
    end
  end
end
