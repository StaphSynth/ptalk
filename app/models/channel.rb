class Channel < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  validates :name, presence: true,
                  length: { maximum: 100 },
                  uniqueness: true,
                  case_sensitive: false
end
