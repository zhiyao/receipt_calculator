require 'CSV'
require_relative '../receipt'

describe Receipt do
  it "should parse the csv file" do
    receipt = Receipt.new
    CSV.foreach('../fixtures/input1.csv') do |row|
      puts '***'
      puts row.inspect
      puts '***'
      receipt.parse(row)
    end
    puts receipt.inspect
  end
end
