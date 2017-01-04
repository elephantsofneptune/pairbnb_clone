class CreatePaymentsTable < ActiveRecord::Migration
  def change
    create_table :payments_tables do |t|
        t.belongs_to :reservation, index: true
        t.integer :amount
    end
  end
end
