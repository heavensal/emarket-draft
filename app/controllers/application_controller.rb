class ApplicationController < ActionController::Base
  # Autoriser uniquement les navigateurs modernes prenant en charge les formats actuels.
  allow_browser versions: :modern
  add_flash_types :success

  before_action :initialize_cart, if: :user_signed_in?
  before_action :authenticate_user!

  private

  def initialize_cart
    @cart ||= current_user.carts.find_or_create_by(status: 'pending', total_price: 0)
    @cart.save! if @cart.new_record?
  end
end
