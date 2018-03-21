class Booking < ActiveRecord::Base

  validates :room, presence: true, format: { with: /\A\d{2}[1-9]\z/ }
  validates_date :start
  validates_date :end, :on_or_after => lambda { :start }

end
