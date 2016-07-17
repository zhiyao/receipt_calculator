require_relative '../receipt'
require 'CSV'

def fixtures_path(csv)
  File.absolute_path(File.join('./spec/fixtures/', csv))
end

describe Receipt do
  context "output" do
    let(:result) { [["Quantity", "Product", "Price"], ["1", "book", "12.49"], ["1", "music cd", "16.49"], ["1", "chocolate bar", "0.85"], [], ["Sales Taxes", "1.50"], ["Total", "29.83"]] }
    it "should be able to output to csv" do
      receipt = Receipt.new
      input = fixtures_path('input1.csv')
      receipt.parse(input)
      receipt.to_csv(fixtures_path('output1.csv'))

      arr_of_arrs = []
      CSV.foreach(fixtures_path('output1.csv')) do |row|
        arr_of_arrs << row.map{ |e| e.strip!; e.gsub(/\u0000/, '')}
      end

      expect(arr_of_arrs).to eq(result)
    end
  end

  context "parse input string" do
    it "should parse a input string" do
      receipt = Receipt.new
      input = "Quantity, Product, Price
        1, book, 12.49
        1, music cd, 14.99
        1, chocolate bar, 0.85"
      receipt.parse(input)
      expect(receipt.to_s).to include("1, book, 12.49\n1, music cd, 16.49\n1, chocolate bar, 0.85\n\nSales Taxes: 1.50\nTotal: 29.83")
    end
  end

  context "parse csv file" do
    it "should parse_line the input 1 csv file" do
      receipt = Receipt.new
      input = fixtures_path('input1.csv')
      receipt.parse(input)
      expect(receipt.total_taxes).to eq(BigDecimal('1.5'))
      expect(receipt.total_after_tax).to eq(BigDecimal('29.83'))

      expect(receipt.to_s).to include("1, book, 12.49\n1, music cd, 16.49\n1, chocolate bar, 0.85\n\nSales Taxes: 1.50\nTotal: 29.83")
    end

    it "should parse_line the input 2 csv file" do
      receipt = Receipt.new
      input = fixtures_path('input2.csv')
      receipt.parse(input)
      expect(receipt.total_taxes).to eq(BigDecimal('7.65'))
      expect(receipt.total_after_tax).to eq(BigDecimal('65.15'))

      expect(receipt.to_s).to include("1, imported box of chocolates, 10.50\n1, imported bottle of perfume, 54.65\n\nSales Taxes: 7.65\nTotal: 65.15")
    end

    it "should parse_line the input 3 csv file" do
      receipt = Receipt.new
      input = fixtures_path('input3.csv')
      receipt.parse(input)
      expect(receipt.total_taxes).to eq(BigDecimal('6.7'))
      expect(receipt.total_after_tax).to eq(BigDecimal('74.68'))

      expect(receipt.to_s).to include("1, imported bottle of perfume, 32.19\n1, bottle of perfume, 20.89\n1, packet of headache pills, 9.75\n1, imported box of chocolates, 11.85\n\nSales Taxes: 6.70\nTotal: 74.68")
    end
  end
end
