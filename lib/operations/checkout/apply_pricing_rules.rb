class Checkout
  # :nodoc:
  class ApplyPricingRules
    # @param checkout [CheckoutStruct]
    # @return [CheckoutStruct]
    def call(checkout)
      checkout.pricing_rules.each do |rule|
        checkout = rule.call(checkout)
      end

      checkout
    end
  end
end
