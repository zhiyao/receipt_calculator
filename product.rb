require_relative './tax'
require 'bigdecimal'

class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
