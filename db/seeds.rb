# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

require 'open-uri'
require 'json'

filepath = 'products.json'

serialized_products = File.read(filepath)

products = JSON.parse(serialized_products)

p products

# product = Spree::Product.create(name: "banan2a2", description: "app2le2", shipping_category: Spree::ShippingCategory.first, price: '10')
# img_file = URI.open('https://www.naturgeflechte24.de/wp-content/uploads/2020/02/kek-g-4737_einkaufskorb_weide.jpg')

# img = ::Spree::Image.new(viewable_id: product.master_id, viewable_type: "Spree::Variant")
# img.attachment.attach(io: img_file, filename: "banana.jpg", content_type: 'image/png')
# img.save
