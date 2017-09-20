module PricingRules
  # fully discounts one of items for each x items,
  # where x is the quantity defined in rule item
  class BuyXGetOneFree < BaseRule
    private

    def calculate_items(items)
      rule_item = find_rule_item(items.first.code)
      return items unless rule_item

      eligible_qty = eligible_items_qty(items, rule_item)
      return items unless eligible_qty.positive?

      items.map.with_index do |item, ix|
        next item unless ix < eligible_qty
        Checkout::ItemStruct.new(item.to_h.merge(discount: item.price))
      end
    end

    def eligible_items_qty(items, rule_item)
      items.size / rule_item['quantity']
    end
  end
end