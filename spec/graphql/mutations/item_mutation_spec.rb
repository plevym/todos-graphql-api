RSpec.describe Mutations::ItemMutation do
  describe 'creating a new record' do
    let!(:todo_list) { create(:todo_list) }

    it 'adds a new item' do
      args = {
        todo_list_id: todo_list.id,
        name:         'An amazing name'
      }

      subject.fields['create_item'].resolve(nil, args, nil)

      expect(Item.count).to eq(1)
      expect(Item.last.name).to eq(args[:name])
    end
  end
end
