require_relative './product'

class LineItem
  attr_accessor :quantity, :product, :price

  def initialize(options)
    @quantity = options[:quantity]
    @product = Product.new(name: options[:product], price: options[:price])
    @price = options[:price]
  end
end

class Receipt
  attr_accessor :tax, :total, :line_items

  def initialize()
    @line_items = []
  end

  def parse(line)
    if line.kind_of?(Array)
      line.map(&:strip)
    else
      line.split(',').map(&:strip)
    end
    if line[0] != 'Quantity'
      @line_items << LineItem.new(quantity: line[0],
                                  product: line[1],
                                  price: line[2])
    end
  end
end


# product
# - name
# - type
# - shelf_price
# - shelf_price_with_tax
# - imported
#
# tax
# - type
# - tax
#
# calculator
# - quantity
# - tax
# - total
