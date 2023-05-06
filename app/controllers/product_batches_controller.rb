class ProductBatchesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :new, :create, :show]
  before_action :authenticate_user!, only: [:index, :show]
  def index
    @product_batches = ProductBatch.all
  end

  def new
    @product_batch = ProductBatch.new
    @products = Product.all
  end

  def create
    @product_batch = ProductBatch.new(product_batch_params)
    if @product_batch.save
      flash[:notice] = 'Lote cadastrado com sucesso.'
      redirect_to product_batches_path
    else
      @products = Product.all
      flash.now[:notice] = 'Nao foi possível cadastrar o lote.'
      render 'new'
    end
  end

  def show
    @product_batch = ProductBatch.find(params[:id])
    @product = Product.find(params[:id])
    @products = Product.all
  end

  def new_item
    @product_batch = ProductBatch.new
    @products = Product.all
    @product = Product.find(params[:id])
  end

  def create_item
    @product_batch = ProductBatch.new(product_batch_params)
    if @product_batch.save
      flash[:notice] = 'Item foi incluso ao lote.'
      redirect_to @product_batch
    end
  end

  private
  
  def product_batch_params
    params.require(:product_batch).permit(:code, :start_date, :deadline, :minimum_value, :minimal_difference, :status, :product_id)
  end
end