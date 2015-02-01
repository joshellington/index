class CreateEventAssociationTables < ActiveRecord::Migration
  def change
    create_table :events_venues do |t|
      t.belongs_to :event, index: true
      t.belongs_to :venue, index: true
    end

    create_table :events_performers do |t|
      t.belongs_to :event, index: true
      t.belongs_to :performer, index: true
    end
  end
end
