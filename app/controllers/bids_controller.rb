class BidsController < ApplicationController


  
  def create
    @product_batch = ProductBatch.find(params[:product_batch_id])
    @current_value = @product_batch.minimum_value + @product_batch.bids.maximum(:value).to_f

    if @product_batch.start_date && @product_batch.start_time <= Time.current && 
                @product_batch.deadline && @product_batch.end_time > Time.current
      @bid = @product_batch.bids.new(bid_params)
      @bid.user = current_user

      if @bid.save
        @current_value = @product_batch.minimum_value + @product_batch.bids.maximum(:value).to_f

        flash[:notice] = "Bid created successfully."
        redirect_to product_batch_path(@product_batch.id)
      else
        flash[:notice] = @bid.errors.full_messages.join(", ")
        render :new
      end
    else
      flash[:notice] = "This batch is no longer open for bids."
      redirect_to product_batch_path(@product_batch.id)
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:value)
  end
end
