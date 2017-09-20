shared_examples_for 'checkout scan' do
  describe 'product scan' do
    include_context 'voucher scan'

    it 'adds item then applies promotions then calculates total' do
      checkout.scan(code)

      expect(checkout.items.size).to eq 1
      expect(checkout.total).to eq 5.0

      checkout.scan(code)

      expect(checkout.items.size).to eq 2
      expect(checkout.total).to eq 5.0
    end
  end
end