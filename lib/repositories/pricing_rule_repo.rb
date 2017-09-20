require 'rom/repository'

# :nodoc:
class PricingRuleRepo < ROM::Repository[:pricing_rules]
  def by_code(code)
    pricing_rules.restrict(code: code).one!
  end
end