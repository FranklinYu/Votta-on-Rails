# frozen_string_literal: true

class ChangeSessionComment < ActiveRecord::Migration[5.0]
  def change
    change_column_null :sessions, :comment, false
    change_column_default :sessions, :comment, ''
  end
end
