if @error.nil?
  json.partial! 'topics/topic', topic: @topic
  json.candidates do
    json.partial! 'candidates/candidate', collection: @candidates, as: :candidate
  end
else
  json.error @error
end
