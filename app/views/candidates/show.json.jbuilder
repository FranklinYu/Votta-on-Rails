json.partial! 'candidates/candidate', locals: {candidate: @candidate, user: @current_session&.user}
