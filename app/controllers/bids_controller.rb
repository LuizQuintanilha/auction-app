class BidsController < ApplicationController
  before_action :find_product_batch
  before_action :authenticate_user!

  def new
    @bid = Bid.new
    @bid.user = current_user
  end

  def create
    @bid = @product_batch.bids.build(bid_params)
    @bid.user = current_user
    if @product_batch.present_or_future? == 'Lote em Andamento'
      if @bid.validate_value?
        @bid.save
        flash[:notice] = 'Lance criado com sucesso'
        redirect_to product_batch_path(@product_batch)
      else
        flash[:notice] = 'Novo lance deve ser maior que o valor atual somado com o valor de diferença.'
        redirect_to new_product_batch_bid_path(@product_batch)
      end
    else
      redirect_to product_batches_path, notice: 'Lote ainda não iniciou'
    end
  end

  private

  def find_product_batch
    @product_batch = ProductBatch.find(params[:product_batch_id])
  end

  def bid_params
    params.require(:bid).permit(:value, :user_id, :product_batch_id)
  end
end