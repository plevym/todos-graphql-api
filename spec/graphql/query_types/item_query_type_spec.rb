RSpec.describe QueryTypes::ItemQueryType do
  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance
  # create fake todo lists unsing factory
  let!(:items) { create_list(:item, 3) }

  describe 'querying all items' do
    it 'has a :items that returns a Item type' do
      expect(subject).to have_field(:items).that_returns(types[Types::ItemType])
    end
  end

  it 'returns all our created items when no filter provided' do
    args = {}

    query_result = subject.fields['items'].resolve(nil, args, nil)

    items.each do |item|
      expect(query_result.to_a).to include(item)
    end

    expect(query_result.count).to eq(items.count)
  end

  describe 'querying with filters' do
    let!(:todo_list) { create(:todo_list) }
    let!(:item1)      { create(:item, todo_list_id: todo_list.id) }
    let!(:item2)      { create(:item, todo_list_id: todo_list.id, done: true) }

    it 'filters items by status' do
      args = { done: true }

      query_result = subject.fields['items'].resolve(nil, args, nil)

      expect(query_result.count).to eq(1)
      expect(query_result.first).to eq(item2)
    end
  end
end
