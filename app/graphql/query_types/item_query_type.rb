module QueryTypes
  ItemQueryType = GraphQL::ObjectType.define do
    name 'ItemQueryType'
    description 'The item query type'

    field :items, types[Types::ItemType], 'returns all items' do
      argument :done, types.Boolean

      resolve ->(_obj, args, _ctx) do
        items = Item.all
        items = items.where(done: args[:done]) if args[:done].present?

        items
      end
    end
  end
end
