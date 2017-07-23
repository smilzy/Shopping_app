class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 9).order(:title)
    if params[:search]
      @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 9).order("created_at DESC")
    else
      @products = Product.paginate(:page => params[:page], :per_page => 9).order(:title)
    end
  end
end
