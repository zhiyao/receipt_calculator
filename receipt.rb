require 'CSV'
require_relative './line_item'

class Receipt
  attr_accessor :tax, :total, :line_items

  def initialize()
    @line_items = []
  end

  def csv?(filename, sep: ',')
    return false unless File.exist?(filename)
    content = File.read(filename, :encoding => 'utf-8')
    return false unless content.valid_encoding?
    CSV.parse(content, col_sep: sep)
  end

  def parse(input)
    if csv = csv?(input)
      csv.each do |line|
        parse_line(line)
      end
    end
    input.each_line do |line|
      parse_line(line)
    end
  end

  def parse_line(line)
    if line.kind_of?(Array)
      line = line.map(&:strip)
    else
      line = line.split(',').map(&:strip)
    end
    push_to_line_item(line)
  end


  def total_taxes
    @line_items.inject(0) do |a, e|
      a += e.product.tax * e.quantity
    end
  end

  def total_after_tax
    @line_items.inject(0) do |a, e|
      a += e.product.price_with_tax * e.quantity
    end
  end

  def output
    puts to_s
  end

  def to_csv(filename = 'output.csv')
    CSV.open(filename, 'wb', col_sep: ', ', force_quotes: false, quote_char: "\0") do |csv|
      csv << ['Quantity', 'Product', 'Price']
      @line_items.each do |line_item|
        csv << [line_item.quantity, line_item.product.name, "%.2f" % line_item.product.price_with_tax]
      end
      csv << []
      csv << ['Sales Taxes', "%.2f" % total_taxes]
      csv << ['Total', "%.2f" % total_after_tax]
    end
  end

  def to_s
    buffer = ''
    @line_items.each do |line_item|
      buffer << "#{line_item.quantity}, #{line_item.product.name}, "
      buffer << "%.2f\n" % line_item.product.price_with_tax
    end

    buffer << "\n"
    buffer << 'Sales Taxes: '
    buffer << "%.2f\n" % total_taxes
    buffer << 'Total: '
    buffer << "%.2f\n" % total_after_tax
    buffer
  end

  private

  def push_to_line_item(line)
    if is_not_header_and_is_number(line[0])
      @line_items << LineItem.new(quantity: line[0],
                                  product: line[1],
                                  price: line[2])

    end
  end

  def is_not_header_and_is_number(line)
    line != 'Quantity' && line.match(/^\d$/)
  end
end
