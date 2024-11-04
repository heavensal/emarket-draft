class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @cart = @user.carts.find_by(status: "pending")
  end

  # def pay_cart
  #   @user = current_user
  #   @cart = @user.carts.find_by(status: "pending")

  #   redirect_to cart_path(@cart), notice: "Votre panier a bien été payé"
  # end
end
