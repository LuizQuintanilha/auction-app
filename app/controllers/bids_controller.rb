class BidsController < ApplicationController
  def new
    @product_batch = ProductBatch.find(params[:product_batch_id])
    @bid = @product_batch.bids.new
  end

  def create
    @product_batch = ProductBatch.find(params[:product_batch_id])
    @bid = @product_batch.bids.new(bid_params)
    @last_bid = @product_batch.bids.last&.value || @product_batch.minimum_value
  
    if @product_batch.present_or_future? == 'Lote em Andamento'
      @bid.user = current_user
  
      if @bid.validate_value?(@last_bid)
        @bid.save
        flash[:notice] = "Lance realizado com sucesso"
        redirect_to product_batch_path(@product_batch.id)
      else
        flash[:notice] = ''
        render 'new'
      end
    else @product_batch.present_or_future? == 'Lote Futuro'
      flash[:notice] = "Lote ainda não iniciou."
      redirect_to product_batch_path(@product_batch.id)
    end
  end

  def bid_params
    params.require(:bid).permit(:value)
  end
end
