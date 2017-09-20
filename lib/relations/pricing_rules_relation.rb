# :nodoc:
class PricingRulesRelation < ROM::YAML::Relation
  dataset :pricing_rules

  schema do
    attribute :code,
              Types::String

    attribute :items,
              Types::Array
  end
end