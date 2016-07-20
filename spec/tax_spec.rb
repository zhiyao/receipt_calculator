require_relative '../tax'

describe Tax do
  context "rate" do
    it "returns 15% for imported others type" do
      tax = Tax.new('imported bottle of perfume', '1.00', '1')
      expect(tax.rate).to eq(15)
    end

    it "returns be 10% for non imported others type" do
      tax = Tax.new('bottle of perfume', '1.00', '2')
      expect(tax.rate).to eq(10)
    end

    it "returns be 5% for imported chocolate" do
      tax = Tax.new('imported box of chocolates', '1.00', '2')
      expect(tax.rate).to eq(5)
    end

    it "returns be 0% for non imported book" do
      tax = Tax.new('book', '2.00', '2')
      expect(tax.rate).to eq(0)
    end
  end

  context "type" do
    it "name has book" do
      tax = Tax.new('book', 2, '2.00')
      expect(tax.type).to eq(:book)
    end

    it "name has chocolate" do
      tax = Tax.new('chocolate bar', '2.00', '2')
      expect(tax.type).to eq(:food)
    end

    it "name has pills" do
      tax = Tax.new('packet of headache pills', '2.00', '2')
      expect(tax.type).to eq(:medical)
    end

    it "name is others" do
      tax = Tax.new('imported bottle of perfume', '2.00', '2')
      expect(tax.type).to eq(:others)
    end
  end

  context "imported" do
    it "name has import" do
      tax = Tax.new('imported bottle of perfume', '3.00', 2)
      expect(tax.imported).to be_truthy
    end

    it "name has no import" do
      tax = Tax.new('packet of headache pills', '4.00', 2)
      expect(tax.imported).to be_falsy
      expect(tax.type).to eq(:medical)
    end
  end

  context "round_up_tax_to_nearest_rate" do
    let(:tax) { Tax.new('imported bottle of perfume', 2, '4.00') }

    it "returns the round to 7.15" do
      expect(tax.round_up_nearest_5cents(7.13)).to eq(7.15)
    end

    it "returns the round to 7.15" do
      expect(tax.round_up_nearest_5cents(7.11)).to eq(7.15)
    end

    it "returns the round to 7.15" do
      expect(tax.round_up_nearest_5cents(7.15)).to eq(7.15)
    end

    it "returns the round to 7.10" do
      expect(tax.round_up_nearest_5cents(7.10)).to eq(7.10)
    end

    it "returns the round to 0.6" do
      expect(tax.round_up_nearest_5cents(0.565)).to eq(0.6)
    end
  end

  context "return the right tax and price_after_tax" do
    it "returns the price with tax for non-imported book" do
      tax = Tax.new('book', '12.49', 1)
      expect(tax.price_after_tax).to eq(12.49)
    end

    it "returns the price after tax for music cd" do
      tax = Tax.new('music cd', '14.99', 1)
      expect(tax.price_after_tax).to eq(16.49)
    end

    it "returns the price after tax of chocolate bar" do
      tax = Tax.new('chocolate bar', '0.85', 1)
      expect(tax.price_after_tax).to eq(0.85)
    end

    it "returns the price after tax of imported box of chocolate" do
      tax = Tax.new('imported box of chocolates', '10.00', 1)
      expect(tax.price_after_tax).to eq(10.50)
    end

    it "returns the price after tax of imported bottle of perfume" do
      tax = Tax.new('imported bottle of perfume', '47.50', 1)
      expect(tax.price_after_tax).to eq(54.65)
    end

    it "returns the price after tax of bottle of perfume" do
      tax = Tax.new('bottle of perfume', '18.99', 1)
      expect(tax.price_after_tax).to eq(20.89)
    end

    it "returns the price after tax of headache pills" do
      tax = Tax.new('packet of headache pills', '9.75', 1)
      expect(tax.price_after_tax).to eq(9.75)
    end

    it "returns the price after tax of imported chocolates" do
      tax = Tax.new('box of imported chocolates', '11.25', 1)
      expect(tax.price_after_tax).to eq(11.85)
    end
  end

end
