shared_context 'voucher scan' do
  let(:code) { 'VOUCHER' }

  let(:checkout) { Checkout.new }

  let(:product) { Container[:product_repo].by_code(code) }

  let(:checkout_item) do
    Checkout::ItemStruct.new(
      code: product.code,
      name: product.name,
      price: product.price,
      discount: 0
    )
  end
end