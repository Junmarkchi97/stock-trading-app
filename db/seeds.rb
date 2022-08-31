# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Trader.create(first_name: "Junmark", last_name: "Chi", email: "admin@admin.com", password: "password", admin: true, age: 18)
Trader.create(first_name: "Franco", last_name: "Rivera", email: "trader@trader.com", password: "password", admin: false, age: 18)