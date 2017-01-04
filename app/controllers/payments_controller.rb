class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
    @reservation = Reservation.find(@payment.reservation_id)
  end

  def new
    @payment = Payment.new
    @reservation = Reservation.find(params[:reservation_id])

  end

  def create
    @payment = Payment.new
    @payment.reservation_id = params[:reservation_id]
    @payment.amount = Reservation.find(params[:reservation_id]).total_price
    if @payment.save
      redirect_to @payment
    else
      redirect_to :back
    end
  end
end
