class ChargesController < ApplicationController
  class Amount

    def self.default
      200
    end
  end

def create

  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken])


  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: Amount.default,
    description: "Membership Money - #{current_user.email}",
    currency: 'usd'
    )

  flash[:notice] = "Thank you #{current_user.email}.  Your payment has been recieved."
  current_user.upgrade_acct
  redirect_to edit_user_registration_path


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Membership Money - #{current_user.name}",
      amount: Amount.default
    }
  end

  def update
    current_user.downgrade_acct
    redirect_to edit_user_registration_path
  end
end
