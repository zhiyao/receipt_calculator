require_relative '../receipt'

describe Receipt do
  it "return the correct total_taxes" do
    receipt = Receipt.new
    line1 = ["1", "book", "12.49"]
    line2 = ["1", "music cd", "14.99"]
    line3 = ["1", "chocolate bar", "0.85"]
    receipt.push_to_line_item(line1)
    receipt.push_to_line_item(line2)
    receipt.push_to_line_item(line3)
    expect(receipt.total_taxes).to eq(BigDecimal('1.5'))
  end

  it "return the correct total_after_tax" do
    receipt = Receipt.new
    line1 = ["1", "book", "12.49"]
    line2 = ["1", "music cd", "14.99"]
    line3 = ["1", "chocolate bar", "0.85"]
    receipt.push_to_line_item(line1)
    receipt.push_to_line_item(line2)
    receipt.push_to_line_item(line3)
    expect(receipt.total_after_tax).to eq(BigDecimal('29.83'))
  end
end
