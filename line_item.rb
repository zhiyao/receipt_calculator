require_relative './product'

class LineItem
  attr_accessor :quantity, :product

  def initialize(options)
    @quantity = options[:quantity].to_i
    @product = Product.new(name: options[:product], price: options[:price])
  end
end
