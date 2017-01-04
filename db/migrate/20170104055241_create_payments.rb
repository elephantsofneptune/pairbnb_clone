class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|        
        t.belongs_to :reservation, index: true
      t.integer :amount

      t.timestamps null: false
    end
  end
end
