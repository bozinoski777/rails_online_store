# namespace :deploy do
#   desc "reload the database with seed data"
#   task :seed do
#     on roles(:all) do
#       within current_path do
#         execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production'
#       end
#     end
#   end
# end
namespace :db do
  desc "Seed products in production"
  task :production_product_seed do
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

    Spree::Product.all.each do |product|
      p product
      product.destroy
    end

    require 'open-uri'
    require 'json'

    filepath = 'db/products.json'

    serialized_products = File.read(filepath)

    products = JSON.parse(serialized_products)

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
      img = ::Spree::Image.new(viewable_id: product.master_id, viewable_type: 'Spree::Variant')
      img.attachment.attach(io: img_file, filename: json_product['photo'], content_type: 'image/png')
      img.save
    end
  end
end
