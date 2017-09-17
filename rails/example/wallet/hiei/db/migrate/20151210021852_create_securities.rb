class CreateSecurities < ActiveRecord::Migration
  def change
    create_table :securities do |t|
      t.string :name
      t.references :indexer, index: true, foreign_key: true
      t.integer :tax_type
      t.date :expiration
      t.integer :yield_type

      t.timestamps null: false
    end
  end
end
