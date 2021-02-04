# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#管理ユーザーの作成
User.create!(name: "仙崎 大輔",
             email: "diver@example.com",
             password: "diving",
             password_confirmation: "diving",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

#その他のサンプルユーザの作成
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@divers.co.jp"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end