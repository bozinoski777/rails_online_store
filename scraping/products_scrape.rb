require 'open-uri'
require 'nokogiri'
require 'json'

products = []
n = 0
6.times do
  n += 1
  url = "https://www.naturgeflechte24.de/korbwaren/page/#{n}/"

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.product').each do |element|
    name = element.css('a').css('h2').text
    product_img = element.css('a').css('img').attribute('srcset').value.split[-2]
    link = element.css('a').attribute('href')
    description = ''
    price = ''
    weight = ''

    url = link
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.summary').take(1).each do |element|
      description = element.css('ul').text.strip
      price = element.css('bdi').first.text
    end

    html_doc.search('.woocommerce-product-attributes').each do |element|
      weight = element.css('tr').css('td').text
    end

    product =
    {
      name: name,
      photo: product_img,
      link: link,
      description: description,
      price: price,
      weight: weight
    }
    products << product
  end
  p "page"
end

File.open('products.json', 'wb') do |file|
  file.write(JSON.generate(products))
end
