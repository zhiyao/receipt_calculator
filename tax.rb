require 'bigdecimal'

class Tax
  attr_reader :type, :imported, :quantity, :price

  def initialize(name, price, quantity)
    @price = BigDecimal(price, 3)
    @quantity = BigDecimal(quantity)
    @type = infer_from(name)
  end

  def total_taxes
    taxable(@price) * @quantity
  end

  def total_after_tax
    price_after_tax * @quantity
  end

  def price_after_tax
    @price + taxable(@price)
  end

  def taxable(price)
    tax_rate = BigDecimal.new(rate) / 100.0
    round_up_nearest_5cents(price * tax_rate)
  end

  def rate
    rate = @type == :others ? 10 : 0
    rate += @imported ? 5 : 0
  end

  def round_up_nearest_5cents(rate)
    ((rate * BigDecimal('20.0')).ceil / BigDecimal('20.0')).round(2)
  end

  private

  def infer_from(name)
    @imported = imported_from(name)
    type_from(name)
  end

  def type_from(name)
    case name
    when /book/
      :book
    when /chocolate/
      :food
    when /pills/
      :medical
    else
      :others
    end
  end

  def imported_from(name)
    case name
    when /imported/
      true
    else
      false
    end
  end
end
