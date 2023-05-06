class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :new, :create, :show, :edit, :update]
  before_action :authenticate_user!, only: [:index, :show]
  def index 
    @products = Product.all
  end
  
  def new
    @product = Product.new
    @categories = Category.all
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Produto cadastrado com sucesso.'
      redirect_to products_path
    else
      @categories = Category.all
      flash.now[:notice] = 'Não foi possível cadastrar produto.'
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = 'Produto atualizado com sucesso.'
      redirect_to @product
    else
      @categories = Category.all
      flash.now[:notice] = 'Não foi possível atualizar dados do produto.'
      render 'edit'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :weight, :height, :width, :depth, :photo, :description, :category_id)
  end
end
