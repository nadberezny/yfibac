To run **tests** type:  
`rspec`

To run **console** type:  
`bin/console`

The app is the implementation of Cabify's coding exercise:
https://gist.github.com/patriciagao/377dca8920ba3b1fc8da

Those examples:
```
Items: VOUCHER, TSHIRT, MUG
Total: 32.50€

Items: VOUCHER, TSHIRT, VOUCHER
Total: 25.00€

Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT
Total: 81.00€

Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT
Total: 74.50€
```
are included in `spec/integration/checkout_spec.rb`


### Code guidelines
#### Checkout interface
Object of `Checkout` class is the interface for `#scan` and `#total` actions.
```ruby
co = Checkout.new
co.scan('VOUCHER')
co.total
```  

#### Scan operation
Scan pipelines operations. Each operation responds to `#call` and takes as an input `CheckoutStruct` object 
and outputs new `CheckoutStruct` object. It's implemented in such manner, that it can easily be wrapped in a
computational context (Either monad) for some neat error handling. For example tt can be refactored with ease into `dry-transaction.`

#### Pricing rules
Pricing rules are auto injected into `Checkout` as a dependency from application `Container`. They can also
be passed explicitly:
```ruby
my_pricing_rules = [
  Class.new(BaseRule) do
    def calculate_items(items)
      items
    end
  end
]
Checkout.new(pricing_rules: my_pricing_rules)
```

#### Defining new pricing rules
To add a new rule simply:
1. Define class inheriting from `BaseRule` that implements `#calculate_items`, 
which takes as input `Array<Checkout::ItemStruct>` and requires the same as output.
2. Include new rule in `PricingRules::Manifest::ACTIVE`.

#### Pricing rules preferences
`PricingRuleRepo` is the interface to `pricing_rules` ROM relation. It's resolved from app container on `:pricing_rule_repo` key.
`PricingRules::Manifest::KLASS_TO_CODE_MAP` binds rule classes with persisted rule code.

#### Stubbing rules
Rules can also be easily stubbed in tests:
```ruby
require 'dry/container/stub'
Container.enable_stubs!
Container.stub(:pricing_rules, [->(checkout_struct) { checkout_struct }])
```
#### Bulk purchase
This rule depends on _code_, _discount_ and _quantity_ preferences. For all checkout items within code scope, if their quantity
is equal or greater than quantity preference, then for each item preferred discount is applied.
For different type of items specific required volume and discount can be applied.

#### Buy X get one free
This rule depends on _code_ and _quantity_ preferences. Quantity preference defines for how many items of the same type buyer gets the
same item for free.
For different types of items, specific quantity can be required to fulfill promotion. E.g. you can set that for 3 mugs you get one free,
and for 4 t-shirts you get one for free.

#### Persistance layer
In the real life app this would probably be some SQL RDBMS. Here we have simple YAML file (`db/cabify_db.yml`).
What is important is that interface to the data is completely decoupled from the persistance layer, so it can be replaced with
different storage. ROM library is used for mapping between stored data and Ruby objects.




____
