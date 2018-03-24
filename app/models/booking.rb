class Booking < ActiveRecord::Base

  validates :room, presence: true, format: { with: /\A\d{2}[1-9]\z/ }
  validates_date :start, :on_or_after => :today
  validates_date :end, :after => lambda { :start }

end
