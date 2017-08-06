class AddLiquidateToInvestiment < ActiveRecord::Migration[5.1]
  def change
    add_column :investiments, :liquidate, :integer
  end
end
