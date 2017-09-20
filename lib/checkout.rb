# co = Checkout.new
# co.scan('VOUCHER')
# price = co.total
class Checkout
  include $inject[:pricing_rules]

  def initialize(pricing_rules:)
    @checkout = CheckoutStruct.new(
      items: [],
      pricing_rules: pricing_rules,
      total: 0
    )
  end

  # @return [Array<Checkout::ItemStruct>]
  def items
    @checkout.items
  end

  def scan(code)
    @checkout = Checkout::Scan.new(code).call(@checkout)
  end

  def total
    @checkout.total
  end
end
