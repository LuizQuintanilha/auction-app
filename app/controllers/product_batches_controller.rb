class ProductBatchesController < ApplicationController
  before_action :authenticate_admin!, only: %i[new, create, admin_aprove_batch, edit, update]
  before_action :ser_product_batch, only: %i[ show wait_approve edit update approve present_or_future?]
 
  def index
    @product_batch = ProductBatch.where(status: 2)
  end
  
  def new
    @product_batch = ProductBatch.new
  end
  
  def create
    @product_batch = current_admin.product_batches.build(product_batch_params)
    @product_batch.created_by = current_admin
    if @product_batch.product_ids.empty?
      @product_batch.errors.add(:product_ids, "Deve ser selecionado pelo menos um produto.")
      render 'new'
    elsif @product_batch.save
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
    @bids = Bid.all
    @bid = Bid.new(product_batch: @product_batch)
  end

  def admin_aprove_batch
    @product_batches = ProductBatch.all
    @admin = Admin.find_by(email: params[:email])
    @product_batch.approved_by = current_admin if @product_batch.present?
  end

  def wait_approve
    @product_batch = ProductBatch.find(params[:id])
    @product_batch.created_by = current_admin
    @product_batch.wait_approve!
    redirect_to @product_batch, notice: 'Aprovado'
  end
  
  def approve
    @product_batches = ProductBatch.all
    @product_batch.approved_by = current_admin
    if @product_batch.save
      @product_batch.approve!
      redirect_to @product_batch, notice: 'Aprovado'
    else
      redirect_to @product_batch, notice:  'Não pode ser o mesmo administrador para aprovar o lote'
    end
  end

  def edit
  end

  def update
    current_products = @product_batch.product_ids
    @product_batch.created_by = current_admin
    if @product_batch.update(product_batch_params)
      @product_batch.product_ids.each do |product_id|
        Product.where(id: product_id).update(status: 0)
      end
      current_products.each do |prod|
        unless @product_batch.product_ids.include?(prod)
          Product.where(id: prod).update(status: 2)
        end
      end
      flash[:notice] = 'Lote editado com sucesso.'
      redirect_to aprove_path
    else
      flash.now[:notice] = 'Nao foi possível editar o lote.'
      render 'edit'
    end
  end

  private

  def ser_product_batch
    @product_batch = ProductBatch.find(params[:id])
  end
  
  def product_batch_params
    prod = params.require(:product_batch).permit(:start_time, :end_time, :code, :start_date, 
                                                :deadline, :minimum_value, 
                                         :minimal_difference, :status, product_ids: [])                               
  end
end
