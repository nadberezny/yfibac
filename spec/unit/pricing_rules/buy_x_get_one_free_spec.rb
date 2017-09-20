require 'spec_helper'

describe PricingRules::BuyXGetOneFree do
  describe '#call' do
    include_context 'voucher scan'

    let(:discounted_item) do
      Checkout::ItemStruct.new(
        code: product.code,
        name: product.name,
        price: product.price,
        discount: product.price
      )
    end

    it 'fully discounts one of items for each two items' do
      checkout.scan(code)

      expect(checkout.items).to match_array [checkout_item]
      expect(checkout.total).to eq 5.0

      checkout.scan(code)

      expect(checkout.items).to match_array [checkout_item, discounted_item]
      expect(checkout.total).to eq 5.0

      checkout.scan(code)

      expect(checkout.items).to match_array ([checkout_item] * 2) + [discounted_item]
      expect(checkout.total).to eq 10.0

      checkout.scan(code)

      expect(checkout.items).to match_array ([checkout_item] * 2) + ([discounted_item] * 2)
      expect(checkout.total).to eq 10.0
    end
  end
end
