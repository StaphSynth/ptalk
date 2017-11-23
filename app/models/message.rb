class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :content, presence: true, length: { maximum: 3000 }

  def is_edited?
    updated_at != created_at
  end
end
