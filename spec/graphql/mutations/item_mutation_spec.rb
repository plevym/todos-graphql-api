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

  describe 'editing an item' do
    let!(:todo_list) { create(:todo_list) }
    let!(:item)      { create(:item, todo_list: todo_list)}

    it 'marks the item as done' do
      args = {
        id: item.id
      }

      result = subject.fields['mark_item_done'].resolve(nil, args, nil)

      expect(result.done).to eq(true)
    end
  end

  describe 'deleting an item' do
    let!(:todo_list) { create(:todo_list) }
    let!(:item)      { create(:item, todo_list: todo_list) }
    let!(:item2)     { create(:item, todo_list: todo_list) }
    let!(:item3)     { create(:item, todo_list: todo_list) }

    it 'deletes an item' do
      args = {
        id: item3.id
      }

      subject.fields['delete_item'].resolve(nil, args, nil)

      expect(Item.count).to eq(2)
      expect(Item.all).not_to include(item3)
    end
  end
end
