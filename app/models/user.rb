# frozen_string_literal: true

# @restful_api 1.0
#
# @property [String] email
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 8}
end
