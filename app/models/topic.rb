# frozen_string_literal: true

# @restful_api 1.0
#
# @property title [String]
# @property body [String] Warning: unsanitized
# @property user [User] the creator of this topic, or null if the user is destroyed
class Topic < ApplicationRecord
  belongs_to :user
  has_many :candidates, dependent: :destroy
  validates :title, presence: true
end
