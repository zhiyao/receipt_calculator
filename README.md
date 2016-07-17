#Introduction

## Getting Started

To intialize the receipt library

    require_relative 'receipt'
    receipt = Receipt.new
    receipt.parse('absolute_path/input1.csv')
    receipt.output

## How it works

- Receipt - has many -> Line Items
- Line Items - has many -> Product and Quantity
- Each Product has a price
- The Tax will determine whether the product type and  imported based on the product name
- The Tax will then return the relevant tax rate
- The Product will calculate the tax and price after tax based on the tax rate with shelf price rounded to the nearest 0.05
- The Receipt will then sum the products sales tax and total after tax.
- Receipt is also responsible for the input and output.


## Input

The receipt library accepts a multi-line string text in csv format or a csv file

### string

    input = "Quantity, Product, Price
      1, book, 12.49
      1, music cd, 14.99
      1, chocolate bar, 0.85"
    receipt.parse(input)

### CSV

    receipt.parse('absolute_path/input1.csv')


---

## Output

### Stdout

It outputs the computed receipt

    output = receipt.to_s

The output string would be the following

    1, book, 12.49
    1, music cd, 16.49
    1, chocolate bar, 0.85

    Sales Taxes: 1.50
    Total: 29.83

### CSV

or to output csv. This will generate a default `output.csv`

    receipt.to_csv


to specify csv name. This will generate `output1.csv`

    receipt.to_csv('output1.csv')

---

## Testing

in the root directory, run the following command

    rspec spec
