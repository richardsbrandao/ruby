class CreateIndexers < ActiveRecord::Migration
  def change
    create_table :indexers do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
