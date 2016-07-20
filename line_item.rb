require_relative './product'

class LineItem
  attr_reader :quantity, :product, :tax

  def initialize(name, price, quantity)
    @quantity = quantity
    @product = Product.new(name, price)
    @tax = Tax.new(name, price, quantity)
  end
end
