class Checkout
  # :nodoc:
  class CalculateTotal
    # @param checkout [CheckoutStruct]
    # @return [CheckoutStruct]
    def call(checkout)
      @checkout = checkout
      @checkout = CheckoutStruct.new(params)
    end

    private

    def params
      @checkout.to_h.merge(
        items: @checkout.items,
        total: total
      )
    end

    def total
      @checkout.items.map { |item| item.price - item.discount }.sum
    end
  end
end
