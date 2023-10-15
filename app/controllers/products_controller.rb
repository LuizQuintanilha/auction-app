class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update]

  def index
    @products = Product.all
    response = Faraday.get('http://localhost:4000/api/v1/product_models')
    @product_models = JSON.parse(response.body)
  end

  def show
    @product = Product.find(params[:id])
    id = params[:id]
    response = Faraday.get("http://localhost:4000/api/v1/product_models/#{id}")
    if response.status == 200
      @product_model = JSON.parse(response.body)
    else
      redirect_to products_path, alert: 'Não foi possível carregar o produto'
    end
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Produto cadastrado com sucesso.'
      redirect_to products_path
    else
      @categories = Category.all
      flash.now[:alert] = 'Não foi possível cadastrar produto.'
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = 'Produto atualizado com sucesso.'
      redirect_to @product
    else
      @categories = Category.all
      flash.now[:alert] = 'Não foi possível atualizar dados do produto.'
      render 'edit'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :weight, :height, :width, :depth, :photo, :description, :category_id)
  end
end
