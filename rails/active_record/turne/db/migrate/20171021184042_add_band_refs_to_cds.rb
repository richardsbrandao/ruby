class AddBandRefsToCds < ActiveRecord::Migration[5.1]
  def change
    add_reference :cds, :band, foreign_key: true
  end
end
