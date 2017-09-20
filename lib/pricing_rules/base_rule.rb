module PricingRules
  # In order to apply pricing rule, #calculate_items must be implemented.
  # It is expected that #calculate_items returns an Array of Checkout::ItemStruct.
  class BaseRule
    include $inject[:pricing_rule_repo]

    def call(checkout_struct)
      @checkout = checkout_struct
      @checkout = CheckoutStruct.new(checkout_params)
    end

    private

    # @param checkout_items [Array<Checkout::ItemStruct>]
    # @return [Array<Checkout::ItemStruct>]
    def calculate_items(checkout_items)
      raise NotImplementedError
    end

    def checkout_params
      @checkout.to_h.merge(items: calculated_items)
    end

    def calculated_items
      checkout_item_groups.map do |_, checkout_items|
        calculate_items(checkout_items)
      end.flatten
    end

    def checkout_item_groups
      @checkout.items.group_by(&:code)
    end

    def find_rule_item(code)
      rule_items.find { |item| item['code'] == code }
    end

    def rule_items
      @_rule_items ||= pricing_rule_repo.by_code(rule_code).items
    end

    def rule_code
      Manifest::KLASS_TO_CODE_MAP[self.class]
    end
  end
end