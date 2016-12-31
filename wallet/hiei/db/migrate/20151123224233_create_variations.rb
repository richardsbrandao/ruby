class CreateVariations < ActiveRecord::Migration
  def change
    create_table :variations do |t|
      t.integer :year
      t.integer :month
      t.float :percent
      t.references :indexer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
