require_relative './line_item'

class Receipt
  attr_reader :total, :line_items

  def initialize
    @line_items = []
  end

  def total_taxes
    @line_items.inject(0) { |a, e| a += e.tax.total_taxes }
  end

  def total_after_tax
    @line_items.inject(0) { |a, e| a += e.tax.total_after_tax }
  end

  def push_to_line_item(line)
    if header?(line[0]) && number?(line[0])
      @line_items << LineItem.new(line[1], line[2], line[0])
    end
  end

  private

  def header?(line)
    line.match(/^\d$/)
  end

  def number?(line)
    line != 'Quantity'

  end
end
