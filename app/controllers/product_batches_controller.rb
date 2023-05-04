class ProductBatchesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :new]
  def index
    @product_batches = ProductBatch.all
  end

  def new
    @product_batch = ProductBatch.new
  end

  def create
    @product_batch = ProductBatch.new(product_batch_params)
    if @product_batch.save
      flash[:notice] = 'Lote cadastrado com sucesso.'
      redirect_to product_batches_path
    else
      flash.now[:notice] = 'Nao foi possível cadastrar o lote.'
      render 'new'
    end
  end

  def product_batch_params
    params.require(:product_batch).permit(:code, :start_date, :deadline, :minimum_value, :minimal_difference, :status)
  end
end