RSpec.describe Mutations::TodoListMutation do
  describe 'creating a new record' do
    let (:args) do
      {
        title: 'Some title'
      }
    end

    it 'increases todo lists by 1' do
      subject.fields['create_todo_list'].resolve(nil, args, nil)

      expect(TodoList.count).to eq 1
    end
  end

  describe 'editing a todo list' do
    let!(:todo_list) { create(:todo_list, title: 'Old title') }

    it 'updates the todo list' do
      args = {
        id:    todo_list.id,
        title: 'New title'
      }

      result = subject.fields['edit_todo_list'].resolve(nil, args, nil)

      expect(result.title).to eq(args[:title])
      expect(TodoList.count).to eq(1)
    end
  end

  describe 'deleting a todo list' do
    let!(:todo_list) { create(:todo_list) }

    it 'deletes a todo list' do
      args = {
        id: todo_list.id
      }

      subject.fields['delete_todo_list'].resolve(nil, args, nil)

      expect(TodoList.count).to eq(0)
    end
  end
end
