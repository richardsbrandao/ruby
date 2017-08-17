class AddFieldsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :cpf, :string
    add_column :customers, :birthday, :date
  end
end
