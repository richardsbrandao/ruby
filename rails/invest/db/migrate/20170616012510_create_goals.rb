class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :name
      t.integer :year
      t.integer :value 
      t.decimal :monthly_input
      t.string :type

      t.timestamps
    end
  end
end
