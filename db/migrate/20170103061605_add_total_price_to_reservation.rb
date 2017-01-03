class AddTotalPriceToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :total_price, :integer
  end
end
