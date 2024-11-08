class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]
  # stripe_product_service = Stripe::StripeProductService.new(@product)

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).order(:name)
    @categories = Category.all.sort_by do |category|
      [ params.dig(:q, :category_id_in)&.include?(category.id.to_s) ? 0 : 1, category.name ]
    end
    collection_ids = params.dig(:q, :collections_id_in) || []
    @collections = Collection.all.sort_by do |collection|
      [ collection_ids.include?(collection.id.to_s) ? 0 : 1, collection.name ]
    end
  end

  def show
    @cart_item = CartItem.new(product: @product, price: @product.price, cart: @cart)
  end

  def new
    @product = Product.new
    @categories = Category.order(:name)
    @collections = Collection.order(:name)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, success: "Le Produit a été créé avec succès"
    else
      render :new, alert: "Echec de la création du Produit"
    end
  end

  def edit
    @categories = Category.order(:name)
    @collections = Collection.order(:name)
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), success: "Le Produit a été modifié avec succès"
    else
      render :edit, alert: "Echec de la modification du Produit"
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Le Produit a été supprimé avec succès"
    else
      render :show, alert: "Echec de la suppression du Produit"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, photos: [], collection_ids: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
