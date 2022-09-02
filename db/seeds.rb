# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Initialize trader and admin users
Trader.create(first_name: "Junmark", last_name: "Chi", email: "admin@admin.com", password: "password", admin: true, age: 18)
Trader.create(first_name: "Franco", last_name: "Rivera", email: "trader@trader.com", password: "password", admin: false, age: 18)

#Initialize all available stock codes
@client = Iex.client
@symbols = @client.ref_data_symbols.select {|x| x.name.length < 40}

@symbols.each do |x|
    if Stock.find_by(code: x.symbol) == nil
        s = Stock.new(name: x.name, code: x.symbol, volume: 0)
        s.save!
    end
end