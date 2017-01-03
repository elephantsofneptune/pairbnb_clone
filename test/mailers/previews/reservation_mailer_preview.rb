# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview

    def reservation_notification
        ReservationMailer.reservation_notification(User.first, Reservation.first).deliver_now
    end

end
