class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @cart = @user.carts.find_by(status: "pending")
  end

  def checkout
    @user = current_user
    @cart = @user.carts.find_by(status: "pending")
    @cart.update(status: "awaiting_payment")
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'payment',
      billing_address_collection: 'required',
      success_url: cart_success_url,
      cancel_url: cart_cancel_url,
      line_items: @cart.products.map do |product|
        {
          price: product.stripe_price_id,
          quantity: 1
        }
      end
    )
    redirect_to session.url, allow_other_host: true
  end

  def success
    @user = current_user
    @cart = @user.carts.find_by(status: "awaiting_payment")
    @cart.update(status: "paid")
    redirect_to cart_path(@cart), notice: "Votre paiement a bien été effectué"
  end

  def cancel
    @user = current_user
    @cart = @user.carts.find_by(status: "awaiting_payment")
    @cart.update(status: "pending")
    redirect_to cart_path(@cart), notice: "Votre paiement a été annulé"
  end

  # def pay_cart
  #   @user = current_user
  #   @cart = @user.carts.find_by(status: "pending")

  #   redirect_to cart_path(@cart), notice: "Votre panier a bien été payé"
  # end
end
