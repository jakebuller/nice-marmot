# A list of product image links to seed the products wall
product_images = [
    'http://www.boerandfitch.com/8568-thickbox_default/funny-tshirts-get-real-be-rational.jpg',
    'http://www.printscanada.com/file_library/userfiles/image/t-shirts-custom.jpg',
    'http://digitalderek.typepad.com/sawxblog/photos/2007/playoffs/rockies_suck_tshirts.jpg'
]

# Remove all of the existing products
ActiveRecord::Base.connection.execute("truncate table products")

# Create some dummy products
10.times do |i|
  Product.create(name: "Product ##{i}", description: "A product.", price: rand(9.99...30.00), available: true, image_link: product_images.sample, purchase_link: 'google.ca')
end
