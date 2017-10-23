class CreateCds < ActiveRecord::Migration[5.1]
  def change
    create_table :cds do |t|
      t.integer :year
      t.string :title
      t.integer :sales

      t.timestamps
    end
  end
end
