class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.string :name
      t.boolean :done

      t.belongs_to :todo_list, index: true, foreign_key: true, type: :string

      t.datetime :created_at, limit: 6
      t.datetime :updated_at, limit: 6
    end
  end
end
