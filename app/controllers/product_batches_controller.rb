class ProductBatchesController < ApplicationController
  before_action :authenticate_admin!, only: %i[ new create admin_aprove_batch edit update expired_batches destroy  ]
  before_action :authenticate_user!, only: %i[ show_result ]
  before_action :set_product_batch, only: %i[ destroy show wait_approve edit update approve present_or_future? destroy waiting_close close_batch ]

  def authenticate_user!
    unless admin_signed_in? || user_signed_in?
      authenticate_user!
    end
  end

  def index
    @product_batches = ProductBatch.where("start_date > ? AND start_time > ?", Time.current, Time.current) && 
                        ProductBatch.where(status: 2)
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
    @questions = Question.where(hidden: :true)
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
      redirect_to aprove_path, notice: 'Admin não pode ser o mesmo'
    end
  end

  def expired_batches
    @product_batch = ProductBatch.find_by(params[:product_batch_id])
    @product_batches = ProductBatch.where("deadline <= ? AND end_time < ?", Time.current, Time.current)
    @admin = Admin.find_by(email: params[:email])
    @batch_fishined = current_admin if @product_batches.present?
  end

  def waiting_close
    @product_batch.wait_finish!
  end
  
  def close_batch
    @product_batch.close_batch!
    winning_bid = @product_batch.bids.maximum(:value)
    if @winning_bid
      @winner_info = { code: product_batch.code, email: winning_bid.user&.email }
    end
    redirect_to expired_batches_path, notice: 'Lote encerrado com sucesso'
  end
  
  def show_result
    @product_batches = ProductBatch.where(expired: 2) 
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
  
  def destroy
    @product_batch = ProductBatch.find(params[:id])
    product_ids = @product_batch.products.pluck(:id)
    Product.transaction do
      Product.where(id: product_ids).update(status: 2)
      @product_batch.bids.destroy_all
      @product_batch.product_batch_items.destroy_all
      @product_batch.destroy
    end
    redirect_to expired_batches_path, notice: 'Lote excluído com sucesso.'
  end

  def search
    @query = params[:query]
    @product_batches = ProductBatch.joins(:products).where("product_batches.code LIKE :query OR products.name LIKE :query", query: "%#{@query}%")
  end
  
  def user_space
    @user = current_user
    @product_batches = ProductBatch.joins(:bids).where(bids: { user_id: @user.id }).distinct
  end

  private

  def favorite_option(product_batch)
    @favorite = Favorite.new
    return unless user_signed_in? && current_user.favorite_products.include?(product_batch)

    @favorite = current_user.favorites.find { |fav| fav.product_batch_id == product_batch.id }
  end

  def set_product_batch
    @product_batch = ProductBatch.find(params[:id])
  end
  
  def product_batch_params
    params.require(:product_batch) .permit(:start_time, :end_time, 
            :code, :start_date, 
            :deadline, :minimum_value, 
            :minimal_difference, :status, :expired, product_ids: [])                               
  end
end
