require 'spec_helper'

describe Checkout::AddItem do
  include_context 'voucher scan'

  describe '#call' do
    it 'adds item to checkout' do
      checkout.scan(code)
      expect(checkout.items).to match_array [checkout_item]
    end
  end
end