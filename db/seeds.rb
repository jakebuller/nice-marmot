# A list of product image links to seed the products wall
product_images = [
    'http://www.boerandfitch.com/8568-thickbox_default/funny-tshirts-get-real-be-rational.jpg',
    'http://www.printscanada.com/file_library/userfiles/image/t-shirts-custom.jpg',
    'http://digitalderek.typepad.com/sawxblog/photos/2007/playoffs/rockies_suck_tshirts.jpg'
]

# Remove all of the existing products
ActiveRecord::Base.connection.execute("truncate table products")

# Create some dummy products
9.times do |i|
  Product.create(
         name: 'Brian Surgeon',
         description: 'An instant classic, Brian Surgeon is the epitome of a ridiculous shirt. We think it\'s Hilarious and we hope you do too!',
         price: 15.99,
         available: true,
         image_link: 'brian_surgeon.png',
         purchase_link: 'http://teespring.com'
  )

end
