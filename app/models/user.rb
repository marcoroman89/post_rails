class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username,
    presence: true,
    length: { within: 5..20 },
    uniqueness: true
    validates_format_of :username, with: /\A[A-Za-z0-9]+\Z/, message: "can only include letters and numbers"

  validates :password,
    presence: true,
    on: :create,
    length: { minimum: 5 }
end 