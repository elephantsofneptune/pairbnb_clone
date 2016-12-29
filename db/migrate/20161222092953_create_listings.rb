class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
        t.belongs_to :user, index: true

      t.string :title
      t.string :description
      t.integer :pax

      t.timestamps null: false
    end
  end
end
