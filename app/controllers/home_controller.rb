class HomeController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  #before_action :authenticate_user!, only: [:index]
  def index
    @products = Product.all
  end
end
