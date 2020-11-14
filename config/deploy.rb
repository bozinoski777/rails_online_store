# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "rails_online_store"
set :repo_url, "git@github.com:bozinoski777/rails_online_store.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/#{fetch :application}"
load 'lib/capistrano/tasks/seed.rb'
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# namespace :baba do
#   desc "Seed products in production"
#   task :production_product_seed do
#     # Taxonomy root
#     Spree::Taxonomy.find_or_create_by(name: 'Produkte')
#     # Taxonomy Branch I
#     Spree::Taxon.find_or_initialize_by(name: 'Körbe').update(taxonomy: Spree::Taxonomy.find_by(name:'Produkte'), parent: Spree::Taxon.find_by(name:'Produkte'))
#     Spree::Taxon.find_or_initialize_by(name: 'Zäune').update(taxonomy: Spree::Taxonomy.find_by(name:'Produkte'), parent: Spree::Taxon.find_by(name:'Produkte'))
#     Spree::Taxon.find_or_initialize_by(name: 'Gartengestaltung').update(taxonomy: Spree::Taxonomy.find_by(name:'  Produkte'), parent: Spree::Taxon.find_by(name:'Produkte'))

#     # Taxonomy Branch II
#     korb_produkte = %w(Einkaufskörbe Erntekörbe Brotkörbe Kaminholzkörbe Geschenkkörbe Dekokörbe Katzenmöbel Hundemöbel Weidenkörbe)
#     zaun_produkte = %w(Weidenenzäune Haselnusszäune Robinienzäune Lärchenzäune)
#     garten_produkte = %w(Hochbeete Pflanzkästen Voegelhäuser Gewächshäuser)

#     # Koerbe Branch
#     korb_produkte.each do |produkt|
#       Spree::Taxon.find_or_initialize_by(name: produkt).update(taxonomy: Spree::Taxonomy.find_by(name: 'Körbe'), parent: Spree::Taxon.find_by(name: 'Körbe'))
#     end

#     # Zaeune Branch
#     zaun_produkte.each do |produkt|
#       Spree::Taxon.find_or_initialize_by(name: produkt).update(taxonomy: Spree::Taxonomy.find_by(name: 'Zäune'), parent: Spree::Taxon.find_by(name: 'Zäune'))
#     end

#     # Garten Branch
#     garten_produkte.each do |produkt|
#       Spree::Taxon.find_or_initialize_by(name: produkt).update(taxonomy: Spree::Taxonomy.find_by(name: 'Gartengestaltung'), parent: Spree::Taxon.find_by(name: 'Gartengestaltung'))
#     end

#     Spree::Product.all.each do |product|
#       p product
#       product.destroy
#     end

#     require 'open-uri'
#     require 'json'

#     filepath = 'db/products.json'

#     serialized_products = File.read(filepath)

#     products = JSON.parse(serialized_products)

#     products['products'].each do |json_product|
#       product = Spree::Product.create(name: json_product['name'],
#                                       description: json_product['description'],
#                                       shipping_category: Spree::ShippingCategory.first,
#                                       price: json_product['price'],
#                                       weight: json_product['weight'],
#                                       available_on: '2020/11/04',
#                                       cost_currency: 'EUR',
#                                       taxons: Spree::Taxon.where(name: json_product['taxons']))

#       img_file = URI.open(json_product['photo'])
#       img = ::Spree::Image.new(viewable_id: product.master_id, viewable_type: 'Spree::Variant')
#       img.attachment.attach(io: img_file, filename: json_product['photo'], content_type: 'image/png')
#       img.save
#     end
#   end
# end

namespace :deploy do
 puts "\n=== Seeding Database ===\n"
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end
