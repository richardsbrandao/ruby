class CreateIrs < ActiveRecord::Migration[5.1]
  def change
    create_table :irs do |t|
      t.string :tax

      t.timestamps
    end
  end
end
