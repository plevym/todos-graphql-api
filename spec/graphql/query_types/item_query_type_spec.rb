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

  it 'returns all our created items' do
    query_result = subject.fields['items'].resolve(nil, nil, nil)

    items.each do |item|
      expect(query_result.to_a).to include(item)
    end

    expect(query_result.count).to eq(items.count)
  end
end
