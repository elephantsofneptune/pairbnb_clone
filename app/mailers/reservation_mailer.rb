class ReservationMailer < ApplicationMailer
  default from: 'erwhey92@gmail.com'

    def reservation_notification(host, reservation)
        # OBJECT VARS
        @reservation = reservation
        @customer = User.find(@reservation.user_id)
        @host = host

        # STRING VARS
        @host_name = @host.name
        @customer_name = @customer.name
        @date_start = @reservation.date_start.strftime('%v')
        @date_end = @reservation.date_end.strftime('%v')
        @url = reservation_url(@reservation.id)

        mail(
            to: "#{@host.email}",
            subject: "[AirBnbClone] Reservation from #{@customer.name}"
        )

    end
end
