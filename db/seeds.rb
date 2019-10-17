# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
    @author = Author.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    puts "Author Created: #{@author.formatted_name}"
end

Author.all.each do |author|
    10.times do |i|
        @post = author.posts.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4), created_at: Time.now - rand(356).days)
        puts "Post Created: #{@post.title}"
    end
end

Post.all.each do |post|
    5.times do |i|
        @comment = post.comments.create!(body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4), created_at: Time.now - rand(356).days)
        puts "Comment Created: #{@comment.body}"
    end
end
