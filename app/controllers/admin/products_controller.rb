class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, @product], notice: 'Product was successfully created.'
    else
      render action: "new"
    end
  end

  def edit

  end

  def update
    @product = Product.find(product_params)

    if @product.update_attributes(params[:product])
      redirect_to [:admin, @product], notice: 'Product was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy

    @product.destroy

    redirect_to admin_products_url
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
