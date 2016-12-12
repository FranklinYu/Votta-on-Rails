# frozen_string_literal: true

# @restful_api 1.0
#
# @property [String] body Warning: contains unsanitized content
# @property [User] user the creator of this candidate, or null if the user is destroyed
# @property [Topic] topic this candidate belongs to
class Candidate < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  validates :body, presence: true
end
