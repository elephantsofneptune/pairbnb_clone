class DropPaymentsTable < ActiveRecord::Migration
  def change
    drop_table :payments_tables
    drop_table :payments
  end
end
