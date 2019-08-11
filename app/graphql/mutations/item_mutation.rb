module Mutations
  ItemMutation = GraphQL::ObjectType.define do
    name 'ItemMutation'
    description 'Mutation type for item'

    field :create_item, Types::ItemType do
      argument :todo_list_id, !types.ID
      argument :name, !types.String

      resolve ->(_obj, args, _ctx) do
        todo_list = TodoList.find(args[:todo_list_id])

        return unless todo_list

        todo_list.items.create!(
          name: args[:name]
        )
      end
    end

    field :mark_item_done, Types::ItemType do
      argument :id, !types.ID, 'the id of the item to mark as done'

      resolve ->(_obj, args, _ctx) do
        item = Item.find(args[:id])

        item.update!(
          done: true
        )

        item
      end
    end

    field :delete_item, Types::ItemType do
      argument :id, !types.ID, 'id of the item to delete'

      resolve ->(_obj, args, _ctx) do
        item = Item.find(args[:id])

        item.destroy
      end
    end
  end
end
