json.extract! candidate, :id, :body, :topic_id, :created_at, :updated_at
json.upvote_count candidate.votes.count
json.upvoted !candidate.votes.find_by_user_id(user.id).nil? unless user.nil?
json.partial! 'user', locals: {user: candidate.user}
