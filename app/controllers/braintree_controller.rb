class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end
  
  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    payment = Payment.find(params[:checkout_form][:payment_id])
    result = Braintree::Transaction.sale(
        :amount => payment.amount,
        :payment_method_nonce => nonce_from_the_client,
        :options => {
            :submit_for_settlement => true
            }
        )

    if result.success?
        payment.transaction_id = result.transaction.id
        payment.status = result.transaction.status
        payment.save
        redirect_to Reservation.find(payment.reservation_id), :flash => { :success => "Transaction successful" }
    else
        redirect_to :back, :flash => { :error => result.errors.first.message }
    end
  end
end
