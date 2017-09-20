require 'spec_helper'

describe PricingRules::BulkPurchase do
  describe '#call' do
    include_context 'voucher scan'

    context 'bulk purchase' do
      let(:code) { 'TSHIRT' }

      let(:discounted_item) do
        Checkout::ItemStruct.new(
          code: product.code,
          name: product.name,
          price: product.price,
          discount: 1.0
        )
      end

      it 'reduces price depending on items quantity' do
        checkout.scan(code)

        expect(checkout.items).to match_array [checkout_item]
        expect(checkout.total).to eq 20.0

        2.times { checkout.scan(code) }

        expect(checkout.items).to match_array [discounted_item] * 3
        expect(checkout.total).to eq 57.0
      end
    end
  end
end