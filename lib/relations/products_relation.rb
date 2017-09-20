# :nodoc:
class ProductsRelation < ROM::YAML::Relation
  dataset :products

  schema do
    attribute :code,
              Types::String

    attribute :currency,
              Types::String

    attribute :name,
              Types::String

    attribute :price,
              Types::Float
  end
end