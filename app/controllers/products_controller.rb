class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :show]

  def new
    @product = Product.new
    @categories = Category.all
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Produto cadastrado com sucesso.'
      redirect_to root_path
    else
      @categories = Category.all
      flash.now[:notice] = 'Não foi possível cadastrar produto.'
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :weight, :height, :width, :depth, :photo, :description, :category_id)
  end
end
