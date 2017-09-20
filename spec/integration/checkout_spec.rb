require 'spec_helper'

describe 'Checkout scan' do
  context 'pricing rules' do
    include_context 'voucher scan'
    {
      %w[VOUCHER TSHIRT MUG] => 32.5,
      %w[VOUCHER TSHIRT VOUCHER] => 25.0,
      %w[TSHIRT TSHIRT TSHIRT VOUCHER TSHIRT] => 81.0,
      %w[VOUCHER TSHIRT VOUCHER VOUCHER MUG TSHIRT TSHIRT] => 74.5
    }.each do |codes, total|
      it 'applies multiple promotions' do
        codes.each { |code| checkout.scan(code) }

        expect(checkout.total).to eq total
      end
    end
  end
end
