class ProductModelsController < ApplicationController
  def index
    response = Faraday.get('http://localhost:4000/api/v1/product_models')
    @product_models = JSON.parse(response.body)
  end

  def show
    id = params[:id]
    response = Faraday.get("http://localhost:4000/api/v1/product_models/#{id}")
    if response.status == 200
      @product_model = JSON.parse(response.body)
    else
      redirect_to products_path, alert: 'Não foi possível carregar o produto'
    end
  end
end