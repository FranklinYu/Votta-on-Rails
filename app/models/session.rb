# frozen_string_literal: true

# @restful_api 1.0
#
# @property [String] comment
class Session < ApplicationRecord
  belongs_to :user
end
