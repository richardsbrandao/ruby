class CreateMusicians < ActiveRecord::Migration[5.1]
  def change
    create_table :musicians do |t|
      t.string :name
      t.date :born
      t.string :country

      t.timestamps
    end
  end
end
