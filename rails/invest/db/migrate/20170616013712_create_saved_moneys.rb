class CreateSavedMoneys < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_moneys do |t|
      t.decimal :value, :precision => 8, :scale => 2
      t.datetime :date
      t.references :investiment, foreign_key: true

      t.timestamps
    end
  end
end
