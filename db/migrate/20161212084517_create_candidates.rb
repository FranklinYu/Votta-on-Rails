class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.text :body
      t.references :topic, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
