class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorite, only: %i[ destroy ]

  def create
    @favorite = Favorite.new(favorite_params)
    @product_batch = ProductBatch.find(params[:favorite][:product_batch_id])
    if @favorite.save
      redirect_to product_batches_path, notice: "Lote #{@product_batch.code} favoritado com sucesso"
    else
      redirect_to product_batch_path(@product_batch)
    end
  end

  def destroy
    if @favorite.destroy
      return redirect_to favorite_table_path, notice: "Lote desfavoritado com sucesso"
    end
  end

  def favorite_table
    return unless user_signed_in?
    @product_batch = ProductBatch.where(@product_batch == :product_batch_id)
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id, product_batch_id: @product_batch)
    #binding.pry
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def favorite_params
    params
      .require(:favorite)
      .permit(:user_id, :product_batch_id)
  end
end
