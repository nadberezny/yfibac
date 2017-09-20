class Checkout
  # Scan pipelines operations.
  # Each operation responds to #call and takes as an input CheckoutStruct object
  # and outputs new CheckoutStruct object.
  class Scan
    def initialize(code)
      @code = code
    end

    # @param checkout [CheckoutStruct]
    # @return [CheckoutStruct]
    def call(checkout)
      @checkout = checkout
      @checkout = add_item
      @checkout = apply_pricing_rules
      @checkout = calculate_total
    end

    private

    def add_item
      Checkout::AddItem.new(@code).call(@checkout)
    end

    def apply_pricing_rules
      Checkout::ApplyPricingRules.new.call(@checkout)
    end

    def calculate_total
      Checkout::CalculateTotal.new.call(@checkout)
    end
  end
end
