class Channel < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :contributors, through: :messages, source: :user
  has_many :private_conversations
  has_many :private_contributors, through: :private_conversations, source: :user

  validates :name, presence: true,
                  length: { maximum: 100 },
                  uniqueness: true,
                  case_sensitive: false

  def is_public?
    !private
  end

  def is_private?
    private
  end

  def authorized_contributor?(user)
    is_public? || user == self.user ||
    private_contributors.include?(user)
  end
end
