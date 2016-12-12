# frozen_string_literal: true

class Candidate < ApplicationRecord
  belongs_to :topic
  belongs_to :user
end
