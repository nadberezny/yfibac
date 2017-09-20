class Checkout
  # :nodoc:
  class ItemStruct < ::BaseStruct
    attribute :code,
              Types::String

    attribute :name,
              Types::String

    attribute :price,
              Types::Decimal

    attribute :discount,
              Types::Decimal
  end
end