require_relative '../product'

describe Product do
  it "returns the price with tax for non-imported book" do
    product = Product.new('book', '12.49')
    expect(product.name).to eq('book')
    expect(product.price).to eq('12.49')
  end
end
