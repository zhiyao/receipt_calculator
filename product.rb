require_relative './tax'

class Product
  attr_accessor :name, :type, :shelf_price, :shelf_price_with_tax, :imported

  def initialize(options)
    @name = options[:name]
    @shelf_price = options[:price]
    @imported = false

    @tax = Tax.new(name: options[:name])
  end

  def price_with_tax
    @shelf_price.to_f * @tax.rate.to_f / 100.0
  end

end
