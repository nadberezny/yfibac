require 'spec_helper'

describe Checkout::CalculateTotal do
  include_context 'voucher scan'

  describe '#call' do
    it 'calculates total' do
      checkout.scan(code)
      expect(checkout.total).to eq 5.0
    end
  end
end