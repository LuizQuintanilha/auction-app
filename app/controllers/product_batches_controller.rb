class ProductBatchesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :new]
  def index
    @product_batches = ProductBatch.all
  end

  def new
    @product_batch = ProductBatch.new
  end

end