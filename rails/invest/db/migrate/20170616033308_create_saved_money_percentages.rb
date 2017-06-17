class CreateSavedMoneyPercentages < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_money_percentages do |t|
      t.integer :value
      t.references :saved_money, foreign_key: true
      t.references :goal, foreign_key: true

      t.timestamps
    end
  end
end
