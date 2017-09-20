# Dependencies container
#
# class Foo
#   include $inject[:product_repo]
#
#   def call
#     product_repo.products.first
#   end
# end
class Container
  extend ::Dry::Container::Mixin

  register :pricing_rule_repo do
    PricingRuleRepo.new(resolve(:rom))
  end

  register :product_repo do
    ProductRepo.new(resolve(:rom))
  end

  register :rom do
    ROM.container($rom_config)
  end
end

$inject = Dry::AutoInject(Container)