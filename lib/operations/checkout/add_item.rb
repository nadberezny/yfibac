class Checkout
  # :nodoc:
  class AddItem
    def initialize(code)
      @code = code
    end

    # @param checkout [CheckoutStruct]
    # @return [CheckoutStruct]
    def call(checkout)
      @checkout = checkout
      @checkout = CheckoutStruct.new(params)
    end

    private

    def params
      @checkout.to_h.merge(
        items: @checkout.items.push(checkout_item)
      )
    end


    def checkout_item
      Checkout::ItemStruct.new(
        code: product.code,
        name: product.name,
        price: product.price,
        discount: 0
      )
    end

    def product
      @_product ||= Container[:product_repo].by_code(@code)
    end
  end
end
