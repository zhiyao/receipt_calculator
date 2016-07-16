require_relative '../product'

describe Product do
  it "should return the price with tax for non-imported book" do
    product = Product.new(name: 'book', price: '12.49')
    expect(product.price_with_tax).to eq(12.49)
    expect(product.tax).to eq(0)
  end

  it "should return the price after tax for music cd" do
    product = Product.new(name: 'music cd', price: '14.99')
    expect(product.tax).to eq(1.5)
    expect(product.price_with_tax).to eq(16.49)
  end

  it "should return the price after tax of chocolate bar" do
    product = Product.new(name: 'chocolate bar', price: '0.85')
    expect(product.tax).to eq(0)
    expect(product.price_with_tax).to eq(0.85)
  end

  it "should return the price after tax of imported box of chocolate" do
    product = Product.new(name: 'imported box of chocolates', price: '10.00')
    expect(product.tax).to eq(0.5)
    expect(product.price_with_tax).to eq(10.50)
  end

  it "should return the price after tax of imported bottle of perfume" do
    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.tax).to eq(7.15)
    expect(product.price_with_tax).to eq(54.65)
  end

  it "should return the price after tax of bottle of perfume" do
    product = Product.new(name: 'bottle of perfume', price: '18.99')
    expect(product.tax).to eq(1.9)
    expect(product.price_with_tax).to eq(20.89)
  end

  it "should return the price after tax of headache pills" do
    product = Product.new(name: 'packet of headache pills', price: '9.75')
    expect(product.tax).to eq(0)
    expect(product.price_with_tax).to eq(9.75)
  end

  it "should return the price after tax of imported chocolates" do
    product = Product.new(name: 'box of imported chocolates', price: '11.25')
    expect(product.tax).to eq(0.6)
    expect(product.price_with_tax).to eq(11.85)
  end

  it "should return the right tax" do
    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.round_up_nearest_5cents(7.13)).to eq(7.15)

    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.round_up_nearest_5cents(7.14)).to eq(7.15)

    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.round_up_nearest_5cents(7.12)).to eq(7.15)

    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.round_up_nearest_5cents(7.11)).to eq(7.15)

    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.round_up_nearest_5cents(7.10)).to eq(7.10)

    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.round_up_nearest_5cents(7.15)).to eq(7.15)

    product = Product.new(name: 'imported bottle of perfume', price: '47.50')
    expect(product.round_up_nearest_5cents(0.565)).to eq(0.6)
  end
end
