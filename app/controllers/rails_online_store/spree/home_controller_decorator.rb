# Spree::HomeController.class_eval do
#   before_action :load_data, :only => :index

#       def index
#         product_1 = Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_2 = Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_3 = Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_4 = Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         @homepage_products = [product_1, product_2, product_3, product_4]
#       end
# end



# Spree::HomeController.class_eval do
#   # before_action :check_locale, only: :index
#       def self.prepended(base)
#         base.helper 'spree/products'
#       end
#     def index
#         product_1 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_2 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_3 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_4 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         @homepage_products = [product_1, product_2, product_3, product_4]
#       end
# end


# module RailsOnlineStore
#   module Spree
#     module HomeControllerDecorator
#       def self.prepended(base)
#         base.helper 'spree/products'
#       end
#     def index
#         product_1 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_2 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_3 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         product_4 = ::Spree::Product.find_by!(name: 'Einkaufskorb Weide hell, oval, Henkel, 40 x 26 x 25/42')
#         @homepage_products = [product_1, product_2, product_3, product_4]
#       end
#     end
#   end
# end
# ::Spree::HomeController.prepend RailsOnlineStore::Spree::HomeControllerDecorator if ::Spree::HomeController.included_modules.exclude?(RailsOnlineStore::Spree::HomeControllerDecorator)
