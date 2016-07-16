require 'CSV'
require_relative '../receipt'

describe Receipt do
  it "should parse the input 1 csv file" do
    receipt = Receipt.new
    CSV.foreach('../fixtures/input1.csv') do |row|
      receipt.parse(row)
    end
    expect(receipt.total_taxes).to eq(BigDecimal('1.5'))
    expect(receipt.total_after_tax).to eq(BigDecimal('29.83'))
  end

  it "should parse the input 2 csv file" do
    receipt = Receipt.new
    CSV.foreach('../fixtures/input2.csv') do |row|
      receipt.parse(row)
    end
    expect(receipt.total_taxes).to eq(BigDecimal('7.65'))
    expect(receipt.total_after_tax).to eq(BigDecimal('65.15'))
  end

  it "should parse the input 3 csv file" do
    receipt = Receipt.new
    CSV.foreach('../fixtures/input3.csv') do |row|
      receipt.parse(row)
    end
    expect(receipt.total_taxes).to eq(BigDecimal('6.7'))
    expect(receipt.total_after_tax).to eq(BigDecimal('74.68'))
  end
end
