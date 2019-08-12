class Item < ApplicationRecord
  belongs_to :todo_list

  validates :name, presence: true, uniqueness: true

  after_initialize :init

  def init
    self.done = false if self.done.nil?
  end
end
