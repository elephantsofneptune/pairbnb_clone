class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(reservation)
    reservation.send_notification!
  end
end
