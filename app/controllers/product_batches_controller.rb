class ProductBatchesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :admin_aprove_batch ]
 
  def index
    @product_batches = ProductBatch.where(status: 2)
  end
  
  def new
    @product_batch = ProductBatch.new
  end
  
  def create
    @product_batch = ProductBatch.new(product_batch_params)
    if @product_batch.save
      @product_batch.product_ids.each do |product_id|
        Product.where(id: product_id).update(status: 0)
      end
      flash[:notice] = 'Lote cadastrado com sucesso.'
      redirect_to aprove_path
    else
      flash.now[:notice] = 'Nao foi possível cadastrar o lote.'
      render 'new'
    end
  end

  def show
    @product_batch = ProductBatch.find(params[:id])
  end

  def admin_aprove_batch
    @product_batches = ProductBatch.where(status: 0)
  end

  def wait_approve
    @product_batch = ProductBatch.find(params[:id])
    @product_batch.wait_approve!
    redirect_to @product_batch, notice: 'Aprovado'
  end
  
  def approve
    @product_batch = ProductBatch.find(params[:id])
    @product_batch.approve!
    redirect_to @product_batch, notice: 'Aprovado'
  end

  private
  
  def product_batch_params
    prod = params.require(:product_batch).permit(:code, :start_date, :deadline, :minimum_value, 
                                         :minimal_difference, :status, product_ids: [])
  end
end