class AddDeletedAtToVacancies < ActiveRecord::Migration[5.1]
  def change
    add_column :vacancies, :deleted_at, :datetime
    add_index  :vacancies, :deleted_at
  end
end
