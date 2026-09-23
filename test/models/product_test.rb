require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "Product attributes not empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "Product price must be positive" do
    product = Product.new(title: "Sample Product", description: "Sample Description")
    product.image.attach(io: File.open(Rails.root.join('db', 'images', 'cprpo.png')), filename: 'cprpo.png')
    product.price = -1
    assert product.invalid?
    
    assert_equal(["must be greater than or equal to 0.01"], product.errors[:price])
    product.price = 0

    assert product.invalid?
    assert_equal(["must be greater than or equal to 0.01"], product.errors[:price])
    product.price = 1
    assert product.valid?
  end

  def new_product(filename = "cprpo.png", content_type="image/png")
    Product.new(title: "Sample Product1", description: "Sample Description1", price: 10).tap do |product|
      product.image.attach(io: File.open(Rails.root.join('db', 'images', filename)), filename: filename, content_type: content_type)
    end
  end

  test "image url" do
    product = new_product()
    assert product.valid?
    product = new_product('cprpo.png', 'image/svg+ml')
    assert_not product.valid?, "image/svg+xml must be invalid"

  end
end
