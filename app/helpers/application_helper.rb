module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
  
  def full_title(page_title = '')                     
    base_title = "AK Smart GSM"  
    if page_title.empty?                              
      base_title                                      
    else
      page_title + " | " + base_title                 
    end
  end
  
  def dynamically_update_products
    @products = Product.paginate(:page => params[:page], :per_page => 9).order(:title)
    ActionCable.server.broadcast 'products',
                html: render_to_string('store/index', layout: false)
    ActionCable.server.broadcast 'products',
                html: render_to_string('store/smartphones', layout: false)
  end
end