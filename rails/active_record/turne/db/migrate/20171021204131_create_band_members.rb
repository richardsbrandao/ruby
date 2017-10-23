class CreateBandMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :band_members do |t|
      t.integer :band_id
      t.integer :musician_id
      t.string :role
      t.integer :arrival_at
      t.integer :departure_at

      t.timestamps
    end
  end
end
