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
  image_url: 'nokia3310.png',
  price: 99.00)
# . . .

Product.create!(title: 'Motorola Nexus',
  description:
    %{<p>
      <em>Motorola Nexus </em> 
      Nexus Nexus Nexus.
      </p>},
  image_url: 'Nexus.png',
  price: 1499.00)
# . . .

Product.create!(title: 'Sample Product',
  description:
    %{<p>
      <em>Sample Product </em> 
      Description
      </p>},
  image_url: 'placeholder240x240.png',
  price: 999.99)
# . . .