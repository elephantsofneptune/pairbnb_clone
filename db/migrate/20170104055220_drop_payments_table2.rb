class DropPaymentsTable2 < ActiveRecord::Migration
  def change
    drop_table :payments
  end
end
