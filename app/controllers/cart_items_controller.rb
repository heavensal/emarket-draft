class CartItemsController < ApplicationController
  def create
    @user = current_user
    @cart = @user.carts.find_by(status: "pending")
    @product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.build(cart_item_params)
    if @cart_item.save
      @cart.total_price += @cart_item.price
      @cart.save
      redirect_to cart_path(@cart), notice: "L'article a bien été ajouté au panier."
    else
      # si erreur, on redirige vers la page actuelle
      flash[:alert] = "Erreur lors de l'ajout de l'article au panier : " + @cart_item.errors.full_messages.join(", ")
      render "products/show", status: :unprocessable_entity, product: @product
    end
  end

  def destroy
    @user = current_user
    @cart = @user.carts.find_by(status: "pending")
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      redirect_to cart_path(@cart), notice: "L'article a bien été supprimé du panier."
    else
      flash[:alert] = "Erreur lors de la suppression de l'article du panier."
      render :index, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :price, :cart_id)
  end
end
