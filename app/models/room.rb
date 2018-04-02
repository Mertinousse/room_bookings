
class Room < ActiveRecord::Base

  has_many :bookings

  validates :number, presence: true, format: { with: /\A\d{2}[1-9]\z/ }

end
