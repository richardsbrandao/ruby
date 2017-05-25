class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.date :birthday
      t.string :gender
      t.string :city
      t.references :vacancy, foreign_key: true

      t.timestamps
    end
  end
end
