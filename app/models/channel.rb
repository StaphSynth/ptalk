class Channel < ApplicationRecord
  has_many :messages
  has_many :users

  validates :name, presence: true, length: { maximum: 100 }
end
