class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.date :birthday
      t.string :facebook

      t.timestamps null: false
    end
  end
end
