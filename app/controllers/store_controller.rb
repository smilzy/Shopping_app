class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 9).order(:title)
  end
end
