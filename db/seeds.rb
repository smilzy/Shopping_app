Product.delete_all
Product.create!(title: 'Samsung',
  description:
    %{<p>
      <em>Samsung Galaxy Phone</em>
      NEWEST WITH ROUNDED SCREEN!
      </p>},
  image_url: 'samsung.png',    
  price: 1999.00)
# . . .
Product.create!(title: 'iPhone',
  description:
    %{<p>
      <em>iPhone 8</em>
      No jack but yes for rounded screen?
      </p>},
  image_url: 'iphone.png',
  price: 2499.00)
# . . .

Product.create!(title: 'Nokia 3310',
  description:
    %{<p>
      <em>Nokia 3310 - unbreakable</em> 
      Herp derp.
      </p>},
  image_url: 'nokia.jpg',
  price: 99.00)
