class CreateInvestiments < ActiveRecord::Migration[5.1]
  def change
    create_table :investiments do |t|
      t.string :name
      t.string :model
      t.decimal :year_yield, :precision => 8, :scale => 2
      t.references :ir, foreign_key: true
      t.timestamps
    end
  end
end
