require_relative '../tax'

describe Tax do
  context "rate" do
    it "should be 15% for imported others type" do
      tax = Tax.new(name: 'imported bottle of perfume')
      expect(tax.rate).to eq(15)
    end

    it "should be 10% for non imported others type" do
      tax = Tax.new(name: 'bottle of perfume')
      expect(tax.rate).to eq(10)
    end

    it "should be 5% for imported chocolate" do
      tax = Tax.new(name: 'imported box of chocolates')
      expect(tax.rate).to eq(5)
    end

    it "should be 0% for non imported book" do
      tax = Tax.new(name: 'book')
      expect(tax.rate).to eq(0)
    end
  end

  context "return me the correct type" do
    it "name has book" do
      tax = Tax.new(name: 'book')
      expect(tax.type).to eq(:book)
    end

    it "name has chocolate" do
      tax = Tax.new(name: 'chocolate bar')
      expect(tax.type).to eq(:food)
    end

    it "name has pills" do
      tax = Tax.new(name: 'packet of headache pills')
      expect(tax.type).to eq(:medical)
    end

    it "name is others" do
      tax = Tax.new(name: 'imported bottle of perfume')
      expect(tax.type).to eq(:others)
    end
  end

  context "return me when it is imported" do
    it "name has import" do
      tax = Tax.new(name: 'imported bottle of perfume')
      expect(tax.imported).to be_truthy
    end

    it "name has no import" do
      tax = Tax.new(name: 'packet of headache pills')
      expect(tax.imported).to be_falsy
      expect(tax.type).to eq(:medical)
    end
  end
end
