require 'open-uri'
require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

# Taxonomy root
Spree::Taxonomy.find_or_create_by(name: 'Produkte')
# Taxonomy Branch I
Spree::Taxon.find_or_initialize_by(name: 'Körbe').update(taxonomy: Spree::Taxonomy.find_by(name:'Produkte'), parent: Spree::Taxon.find_by(name:'Produkte'))
Spree::Taxon.find_or_initialize_by(name: 'Zäune').update(taxonomy: Spree::Taxonomy.find_by(name:'Produkte'), parent: Spree::Taxon.find_by(name:'Produkte'))
Spree::Taxon.find_or_initialize_by(name: 'Gartengestaltung').update(taxonomy: Spree::Taxonomy.find_by(name:'  Produkte'), parent: Spree::Taxon.find_by(name:'Produkte'))

# Taxonomy Branch II
korb_produkte = %w(Einkaufskörbe Erntekörbe Brotkörbe Kaminholzkörbe Geschenkkörbe Dekokörbe Katzenmöbel Hundemöbel Weidenkörbe)
zaun_produkte = %w(Weidenenzäune Haselnusszäune Robinienzäune Lärchenzäune)
garten_produkte = %w(Hochbeete Pflanzkästen Voegelhäuser Gewächshäuser)

# Koerbe Branch
korb_produkte.each do |produkt|
  Spree::Taxon.find_or_initialize_by(name: produkt).update(taxonomy: Spree::Taxonomy.find_by(name: 'Körbe'), parent: Spree::Taxon.find_by(name: 'Körbe'))
end

# Zaeune Branch
zaun_produkte.each do |produkt|
  Spree::Taxon.find_or_initialize_by(name: produkt).update(taxonomy: Spree::Taxonomy.find_by(name: 'Zäune'), parent: Spree::Taxon.find_by(name: 'Zäune'))
end

# Garten Branch
garten_produkte.each do |produkt|
  Spree::Taxon.find_or_initialize_by(name: produkt).update(taxonomy: Spree::Taxonomy.find_by(name: 'Gartengestaltung'), parent: Spree::Taxon.find_by(name: 'Gartengestaltung'))
end

puts 'Taxons seeded'

Spree::Product.all.each do |product|
  product.destroy!
end

puts 'Products Deleted'

filepath = 'db/products.json'

serialized_products = File.read(filepath)

products = JSON.parse(serialized_products)

counter = 1
products['products'].each do |json_product|
  product = Spree::Product.create(name: json_product['name'],
                                  description: json_product['description'],
                                  shipping_category: Spree::ShippingCategory.first,
                                  price: json_product['price'],
                                  weight: json_product['weight'],
                                  available_on: '2020/11/04',
                                  cost_currency: 'EUR',
                                  taxons: Spree::Taxon.where(name: json_product['taxons']))

  img_file = URI.open(json_product['photo'])
  # img = ::Spree::Image.new(viewable_id: product.master_id, viewable_type: 'Spree::Variant')
  img = ::Spree::Image.new(viewable_id: product.master_id, viewable: product.master)
  img.attachment.attach(io: img_file, filename: json_product['photo'], content_type: 'image/png')
  img.save!
  puts "#{counter} Product seeded"
  counter += 1
end
