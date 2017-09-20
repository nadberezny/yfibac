require 'rom/repository'

# :nodoc:
class ProductRepo < ROM::Repository[:products]
  def by_code(code)
    products.restrict(code: code).one!
  end
end