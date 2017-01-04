 class Reservation < ActiveRecord::Base
    belongs_to :listing
    belongs_to :user

    has_many :payments

    validates :date_start, presence: true
    validates :date_end, presence: true
    validates :user_id, presence: true
    validates :listing_id, presence: true

    validate :check_overlapping_dates
    # validate :check_max_guests

    def send_notification!
        # TODO Get host email
        listing = Listing.find(self.listing_id)
        host = User.find(listing.user_id)
        # TODO Send an email to the host

        ReservationMailer.reservation_notification(host,self).deliver_now
    end

     def check_overlapping_dates
         listing.reservations.each do |reservation|
              if overlap?(self, reservation)
               return self.errors.add(:messages, "Sorry, but the dates have already been taken")
             end
         end
     end

     def overlap?(x,y)
         (x.date_start - y.date_end) * (y.date_start - x.date_end) > 0
     end
     
     # def check_max_guests
     #     max_guests = listing.pax
     #     return if num_guests < max_guests
     #    errors.add(:max_guests, "Maximum number of guests exceeded")
     # end



end
