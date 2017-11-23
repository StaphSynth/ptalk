class User < ApplicationRecord
  include Clearance::User
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :messages, dependent: :destroy
  has_many :channels, through: :messages

  validates :name, presence: true,
                  length: { maximum: 50 },
                  uniqueness: true
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
