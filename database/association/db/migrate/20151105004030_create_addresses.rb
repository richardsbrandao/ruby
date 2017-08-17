class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :cep
      t.string :name
      t.string :neighborhood
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
