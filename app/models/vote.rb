class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :candidate

  validates :user, uniqueness: {scope: :candidate, message: 'vote only once for each candidate'}
end
