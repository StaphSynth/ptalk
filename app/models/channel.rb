class Channel < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :contributors, through: :messages, source: :user
  has_many :private_conversations
  has_many :private_contributors, through: :private_conversations, source: :user

  validates :name, presence: true,
                  length: { maximum: 100 },
                  uniqueness: true,
                  case_sensitive: false

  def is_public?
    self.public
  end
end
