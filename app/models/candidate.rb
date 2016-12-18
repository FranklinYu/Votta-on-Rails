# frozen_string_literal: true

# @restful_api 1.0
#
# @property body [String] body of the candidate. Non-empty. *Warning: unsanitized*
# @property user [User] the creator of this candidate, or null if the user is destroyed
# @property topic [Topic] this candidate belongs to
class Candidate < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :votes
  validates :body, presence: true
end
