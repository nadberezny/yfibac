# :nodoc:
class CheckoutStruct < BaseStruct
  attribute :items,
            Types::Array

  attribute :pricing_rules,
            Types::Array

  attribute :total,
            Types::Float
end