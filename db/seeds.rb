# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#管理ユーザーの作成
User.create!(name: "Diver one",
             email: "diver@example.com",
             password: "diving",
             password_confirmation: "diving",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

#その他のサンプルユーザの作成
99.times do |n|
  name  = "Diver #{Faker::Internet.username}"
  email = "example-#{n+1}@divers.co.jp"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(12)
12.times do |n|
	dive_number = n+1
	address = Gimei.address.city.to_s
	point = Faker::Creature::Animal.name
	entry = ["ボート","ビーチ"][rand(2)]
	entry_time = Faker::Time.between(from: (13-n).month.ago, to: (12-n).month.ago)
	exit_time = entry_time + 1.hour
	entry_bar = rand(190..210)
	exit_bar = rand(30..80)
	air_temperature = rand(20..30)
	water_temperature = rand(20..30)
	condition = ["晴れ, 穏やか","曇り, 流れあり", "雨, うねり"][rand(3)]
	transparency = rand(5..20)
	ave_depth = rand(10..20).round(1)
	max_depth = rand(20..30).round(1)
	equipment = ["ウェットスーツ, アルミタンク, 4kg","ウェット, スチールタンク, 2kg", "ドライスーツ, アルミタンク, 6kg"][rand(3)]
  comment = Faker::Lorem.paragraphs

  users.each { |user| user.diving_logs.create!(
    dive_number: dive_number,
    address: address,
    point: point,
    entry: entry,
    entry_time: entry_time,
    exit_time: exit_time,
    entry_bar: entry_bar,
    exit_bar: exit_bar,
    air_temperature: air_temperature,
    water_temperature: water_temperature,
    condition: condition,
    transparency: transparency,
    ave_depth: ave_depth,
    max_depth: max_depth,
    equipment: equipment,
    comment: comment) }
end