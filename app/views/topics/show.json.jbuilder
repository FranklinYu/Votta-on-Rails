if @error.nil?
  json.partial! 'topics/topic', topic: @topic
else
  json.error @error
end
