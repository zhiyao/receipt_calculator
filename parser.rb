require 'CSV'
require_relative './receipt'

class Parser
  attr_reader :receipt

  def initialize
    @receipt = Receipt.new
  end

  def parse_csv(filename, sep: ',')
    return false unless File.exist?(filename)
    content = File.read(filename, :encoding => 'utf-8')
    return false unless content.valid_encoding?
    CSV.parse(content, col_sep: sep)
  end

  def parse(input)
    if csv = parse_csv(input)
      csv.each do |line|
        parse_line(line)
      end
    else
      input.each_line do |line|
        parse_line(line)
      end
    end
  end

  def parse_line(line)
    if line.kind_of?(Array)
      line = line.map(&:strip)
    else
      line = line.split(',').map(&:strip)
    end
    @receipt.push_to_line_item(line)
  end

  def to_csv(filename = 'output.csv')
    CSV.open(filename, 'wb', col_sep: ', ', force_quotes: false, quote_char: "\0") do |csv|
      csv << ['Quantity', 'Product', 'Price']
      @receipt.line_items.each do |line_item|
        csv << [line_item.quantity, line_item.product.name, "%.2f" % line_item.tax.price_after_tax]
      end
      csv << []
      csv << ['Sales Taxes', "%.2f" % @receipt.total_taxes]
      csv << ['Total', "%.2f" % @receipt.total_after_tax]
    end
  end

  def output
    puts to_s
  end

  def to_s
    buffer = ''
    @receipt.line_items.each do |line_item|
      buffer << "#{line_item.quantity}, #{line_item.product.name}, "
      buffer << "%.2f\n" % line_item.tax.price_after_tax
    end
    buffer << "\n"
    buffer << 'Sales Taxes: '
    buffer << "%.2f\n" % @receipt.total_taxes
    buffer << 'Total: '
    buffer << "%.2f\n" % @receipt.total_after_tax
    buffer
  end

end
