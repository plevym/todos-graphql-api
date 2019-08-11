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
end
