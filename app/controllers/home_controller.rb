class HomeController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  def index
    @products = Product.all
  end
end
