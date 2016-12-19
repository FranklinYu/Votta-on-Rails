if @error.nil?
  json.partial! 'topics/topic', topic: @topic
  json.candidates do
    json.array! @candidates do |candidate|
      json.partial! 'candidates/candidate', locals: {candidate: candidate, user: @current_session&.user}
    end
  end
else
  json.error @error
end
