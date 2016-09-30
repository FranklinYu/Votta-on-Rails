# frozen_string_literal: true

# @restful_api 1.0
#
# @property [String] title
# @property [String] body Warning: contains unsanitized content
# @property [User] user the creator of this topic, or null if the user is destroyed
class Topic < ApplicationRecord
  belongs_to :user
end
