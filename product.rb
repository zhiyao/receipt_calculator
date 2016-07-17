require_relative './tax'
require 'bigdecimal'

class Product
  attr_accessor :name, :type, :price

  def initialize(options)
    @name = options[:name]
    @price = BigDecimal.new(options[:price], 3)

    @tax = Tax.new(name: options[:name])
  end

  def price_with_tax
    @price + tax
  end

  def tax
    tax_rate = BigDecimal.new(@tax.rate) / 100.0
    round_up_nearest_5cents(@price * tax_rate)
  end

  def round_up_nearest_5cents(rate)
    ((rate * BigDecimal('20.0')).ceil / BigDecimal('20.0')).round(2)
  end
end
