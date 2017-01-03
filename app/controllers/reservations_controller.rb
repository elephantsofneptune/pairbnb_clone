class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    if reservation_from_params[:date_start].empty? || reservation_from_params[:date_end].empty?
      flash[:notice] = "Reservation dates can't be empty"
      redirect_to :back
    else
      @reservation = Reservation.new(reservation_from_params)
      @reservation.user_id = current_user.id
      @reservation.listing_id = params[:listing_id]
      @reservation.total_price
      if @reservation.save
        redirect_to :back
      else
        flash[:notice] = @reservation.errors.messages[:messages].join
        redirect_to :back
      end
    end
  end

  def destroy 
  end

  def edit
  end

  def update
  end

  private
  def reservation_from_params
    params.require(:reservation).permit(
      :date_start, 
      :date_end
      )
  end



end
