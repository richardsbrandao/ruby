class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :gender
      t.integer :birthyear

      t.timestamps
    end
  end
end
