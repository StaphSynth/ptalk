class Post < ApplicationRecord
  has_one :user
  validates :content, presence: true, length: { maximum: 3000 }
end
