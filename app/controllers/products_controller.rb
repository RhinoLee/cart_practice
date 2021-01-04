class ProductsController < ApplicationController

  def index 
    @products = Product.order(updated_at: :desc).where(on_sell: true).includes(:vendor)
  end

  def show 
  end

  
  
end
