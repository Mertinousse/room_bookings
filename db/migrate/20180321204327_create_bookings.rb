class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.belongs_to :room

      t.integer :room_id
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
