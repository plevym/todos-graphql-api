module Mutations
  TodoListMutation = GraphQL::ObjectType.define do
    name 'TodoListMutation'
    description 'Mutation type for todo list'

    field :create_todo_list, Types::TodoListType do
      argument :title, !types.String

      resolve ->(_obj, args, _ctx) do
        TodoList.create!(
          title: args[:title]
        )
      end
    end

    field :edit_todo_list, Types::TodoListType do
      argument :id, !types.ID, 'id of the todolist to edit'
      argument :title, !types.String, 'new title'

      resolve ->(_obj, args, _ctx) do
        todo_list = TodoList.find_by(id: args[:id])

        todo_list.update!(
          title: args[:title]
        )

        todo_list
      end
    end

    field :delete_todo_list, Types::TodoListType do
      argument :id, !types.ID, 'id of the todolist to delete'

      resolve ->(_obj, args, _ctx) do
        todo_list = TodoList.find(args[:id])

        todo_list.destroy
      end
    end
  end
end
