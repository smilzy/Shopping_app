require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  ## Validation tests
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(title:        'Nokia',
                          description:  'Connecting people.',
                          image_url:    'xxxxxxx.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                  product.errors[:price]
                  
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                  product.errors[:price]
                  
    product.price = 1
    assert product.valid?
  end
  
  # Testing for image format validation
  def new_product(image_url)
    Product.new(title:        'Nokia',
                description:  'Connecting people.',
                price:        1,
                image_url:    image_url)
  end
  
  test "image url" do
    ok = %w{ htc.gif htc.jpg htc.png HTC.JPG HTC.Jpg
              http://a.b.c/x/y/z/htc.gif }
    bad = %w{ htc.doc htc.gif/more htc.gif.more }
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end
  
end