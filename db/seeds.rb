# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)


# Spree::Product.all.each do |product|
#   p product
#   product.destroy
# end

require 'open-uri'
require 'json'

filepath = 'db/products.json'

serialized_products = File.read(filepath)

products = JSON.parse(serialized_products)

products['products'].each do |json_product|
  product = Spree::Product.create(name: json_product["name"], description: json_product["description"], shipping_category: Spree::ShippingCategory.first, price: json_product["price"])
  img_file = URI.open(json_product["photo"])

  img = ::Spree::Image.new(viewable_id: product.master_id, viewable_type: "Spree::Variant")
  img.attachment.attach(io: img_file, filename: json_product["photo"], content_type: 'image/png')
  img.save
end
