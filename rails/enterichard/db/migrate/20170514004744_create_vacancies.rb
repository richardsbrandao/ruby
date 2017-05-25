class CreateVacancies < ActiveRecord::Migration[5.1]
  def change
    create_table :vacancies do |t|
      t.string :position
      t.integer :salary
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
