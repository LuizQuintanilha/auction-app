class HomeController < ApplicationController
  def index
    @product_batches = ProductBatch.where('start_date > ? AND start_time > ?', Time.current, Time.current) &&
                       ProductBatch.where(status: 2)
  end
end
