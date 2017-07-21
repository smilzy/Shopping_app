class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_create :has_avatar
  before_update :has_avatar
  
  before_destroy :ensure_not_referenced_by_any_line_item  
  
  validates :title, :description, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: true
  # validates :image_url, allow_blank: true, format: {
  #   with:   %r{\.(gif|jpg|png)\Z}i,
  #   message: 'must be a URL for GIF, JPG, or PNG image.'
  # }
  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes
 
  def quantity_update(product, qty)
    if product.quantity-qty > 0
      product.quantity -= qty
      product.save
    else
      errors.add(:order, 'Brak takiej ilości towaru na magazynie.')# i to nizej!! #
      # throw :abort
    end
    product
  end
    
  private
  
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
      end
    end
    
    def has_avatar
      if avatar?
        image_url = avatar.name
      end
    end
  
end
