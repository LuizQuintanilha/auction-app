class ProductBatchesController < ApplicationController
  before_action :authenticate_admin!, only: %i[ new create admin_aprove_batch edit update expired_batches show_result destroy ]
  before_action :set_product_batch, only: %i[ show_result show wait_approve edit update approve present_or_future? destroy ]
 
  def index
    @product_batches = ProductBatch.where("start_date > ? AND start_time > ?", Time.current, Time.current) && 
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
      redirect_to @product_batch, notice: 'O lote foi encerrado com sucesso.'
    end
  end

  def expired_batches
    @product_batches = ProductBatch.where("deadline < ? AND end_time < ?", Time.current, Time.current)
  end

  def close_batch
    @product_batch = ProductBatch.find(params[:id])
    if @product_batch.bids.any?
      @product_batch.close_batch!
      @winning_bid = @product_batch.bids.last
      if @winning_bid
        @winner_info = { code: @product_batch.code, email: @winning_bid.user.email }
        flash[:notice] = 'Lote encerrado com sucesso.'
      else
        flash[:notice] = 'O lote não recebeu nenhum lance.'
      end
    end
    redirect_to expired_batches_path
  end

  def show_result
    @closed_product_batches = ProductBatch.where(status: 'encerrado')
    @winners_info = []
    @closed_product_batches.each do |product_batch|
      if product_batch.bids.any?
        winning_bid = product_batch.bids.last&.value
        @winners_info << { code: product_batch.code, email: winning_bid.user.email }
      end
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

  def set_product_batch
    @product_batch = ProductBatch.find(params[:id])
  end
  
  def product_batch_params
    params.require(:product_batch).permit(:start_time, :end_time, :code, :start_date, 
                                                :deadline, :minimum_value, 
                                         :minimal_difference, :status, product_ids: [])                               
  end
end
