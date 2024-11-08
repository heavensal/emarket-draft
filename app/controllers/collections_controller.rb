class CollectionsController < ApplicationController
  before_action :set_collection, only: [ :show, :edit, :update, :destroy ]

  def index
    @collections = Collection.all
  end

  def show
    @q = @collection.products.ransack(params[:q])
    @products = @q.result(distinct: true).order(:name)
    @categories = Category.all.sort_by do |category|
      [ params.dig(:q, :category_id_in)&.include?(category.id.to_s) ? 0 : 1, category.name ]
    end
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)

    if @collection.save
      redirect_to @collection, success: "La Collection a été créée avec succès"
    else
      render :new, alert: "Echec de la création de la Collection"
    end
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection, success: "La Collection a été modifiée avec succès"
    else
      render :edit, alert: "Echec de la modification de la Collection"
    end
  end

  def destroy
    if @collection.destroy
      redirect_to collections_path, notice: "La Collection a été supprimée avec succès"
    else
      redirect_to @collection, alert: "Echec de la suppression de la Collection"
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description, :photo)
  end

  def set_collection
    @collection = Collection.find(params[:id])
  end
end
