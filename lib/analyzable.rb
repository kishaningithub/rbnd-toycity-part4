module Analyzable
  # Your code goes here!
  def average_price(products)
    (products.map {|product| product.price.to_f}.reduce(:+) / products.size).round(2)
  end
  def print_report(products)
    report = "Average Price: $#{average_price(products)}"
    report += "Inventory by Brand:"
    count_by_brand(products).each do |key, value|
      report += "  - #{key}: #{value}"
    end
    report += "Inventory by Name:"
    count_by_name(products).each do |key, value|
      report += "  - #{key}: #{value}"
    end
    report
  end
  def count_by_brand(products)
    hash = {}
    products.each do |product|
      if hash[product.brand] then
        hash[product.brand] += 1 
      else
        hash[product.brand] = 1
      end
    end
    hash
  end
  def count_by_name(products)
    hash = {}
    products.each do |product|
      if hash[product.name] then
        hash[product.name] += 1 
      else
        hash[product.name] = 1
      end
    end
    hash
  end
end
