class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy ]

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, success: "La Catégorie a été créée avec succès"
    else
      render :new, alert: "Echec de la création de la Catégorie"
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, success: "La Catégorie a été modifiée avec succès"
    else
      render :edit, alert: "Echec de la modification de la Catégorie"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, notice: "La Catégorie a été supprimée avec succès"
    else
      redirect_to @category, alert: "Echec de la suppression de la Catégorie"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :photo)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
