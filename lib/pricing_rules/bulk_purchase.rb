module PricingRules
  # buying x or more of a product, the price of that product is reduced,
  # where x is the quantity defined in rule item
  class BulkPurchase < BaseRule
    private

    def calculate_items(items)
      rule_item = find_rule_item(items.first.code)
      return items unless rule_item && eligible?(items, rule_item)

      items.map do |item|
        Checkout::ItemStruct.new(
          item.to_h.merge(discount: rule_item['discount'])
        )
      end
    end

    def eligible?(items, rule_item)
      items.size >= rule_item['quantity']
    end
  end
end