require_relative 'bulk_purchase'
require_relative 'buy_x_get_one_free'

module PricingRules
  # Manifest decides which pricing rules can be applied on checkout
  # and maps rule  classes with persisted rule codes.
  module Manifest
    ACTIVE = [
      PricingRules::BulkPurchase,
      PricingRules::BuyXGetOneFree
    ].freeze

    KLASS_TO_CODE_MAP = {
      PricingRules::BulkPurchase => 'bulk-purchase',
      PricingRules::BuyXGetOneFree => 'buy-x-get-one-free'
    }.freeze
  end
end
