class CreateIndexValues < ActiveRecord::Migration[5.1]
  def change
    create_table :index_values do |t|
      t.string :period
      t.decimal :value
      t.references :index, foreign_key: true

      t.timestamps
    end
  end
end
