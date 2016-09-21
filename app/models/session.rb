# frozen_string_literal: true

# @restful_api 1.0
#
# @property [Integer] id
# @property [String] comment
class Session < ApplicationRecord
  before_save do
    self.comment ||= ''
  end

  belongs_to :user
end
