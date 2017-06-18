class ChangeValueAndMonthlyInputGoalToInteger < ActiveRecord::Migration[5.1]
  def change
  	remove_column :goals, :value
  	remove_column :goals, :monthly_input
  	remove_column :saved_moneys, :value

  	add_monetize :goals, :amount
  	add_monetize :goals, :monthly_input
  	add_monetize :saved_moneys, :amount
  end
end
