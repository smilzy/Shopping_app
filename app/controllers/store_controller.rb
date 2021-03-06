class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
    if params[:search]
      @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 9).order("created_at DESC")
    else
      @products = Product.where("quantity > ?", 0).paginate(:page => params[:page], :per_page => 9).order(:title)
    end
  end
  
  def smartphones
    if params[:search]
      @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 9).order("created_at DESC")
    else
      @products = Product.where("quantity > ?", 0).paginate(:page => params[:page], :per_page => 9).order(:title)
    end
  end
  
end
