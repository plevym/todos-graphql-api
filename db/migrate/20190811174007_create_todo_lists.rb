class CreateTodoLists < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_lists, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.string :title

      t.datetime :created_at, limit: 6
      t.datetime :updated_at, limit: 6
    end
  end
end
