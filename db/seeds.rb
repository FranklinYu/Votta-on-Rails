# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
jack = User.create!(email: 'jack@example.com', password: '12341234')
tom = User.create!(email: 'tom@example.net', password: '12341234')

jack.sessions.create!(comment: 'Safari 10.0.1 on Macintosh 10.11.6')
jack.sessions.create!(comment: 'curl/7.43.0')
tom.sessions.create!(comment: 'Chrome 45.0.2454.104 on Macintosh 10.11.6')
tom.sessions.create!(comment: 'my Ruby bot')

t = jack.topics.create!(
  title: 'What is your favorite salad dressing?',
  body: "There are many, but some of them are really classic and exellent. Dressings with different ingredients are regarded as different ones; ones with same ingredient list, but different amount, are regarded as the same ones."
)
jack.topics.create!(
  title: 'Your favorite text editor software?',
  body: 'Text editor is essential to programmers!'
)

t.candidates.create!(body: 'Ranch, no doubt!', user: jack)
t.candidates.create!(body: 'Long live Balsamic!', user: tom)

