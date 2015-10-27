require 'faker'

# Create Users
users = User.all
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
    user.save!
end

# Create Wikis
wikis = Wiki.all
50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    )
end

# Create an admin user
admin = User.create(
  name: 'Admin',
  email: 'admin@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld',
  role: 'admin'
  )
  admin.save!


  admin = User.create(
    name: 'Member',
    email: 'member@example.com',
    password: 'helloworld',
    password_confirmation: 'helloworld',
    role: 'member'
    )
    admin.save!

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
