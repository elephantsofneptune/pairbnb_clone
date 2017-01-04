class AddStatusColumn < ActiveRecord::Migration
  def change
    add_column :payments, :status, :string
    add_column :payments, :transaction_id, :string
  end
end
