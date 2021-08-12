# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Gerando os Users..."
#User.create!([{email: "rgsliras@gmail.com",password:"12345678",admin:0,kind_id:2}])
User.create!([{email: "maria@gmail.com",password:"12345678",admin:1,kind_id:3}])
User.create!([{email: "lily@gmail.com",password:"12345678",admin:1,kind_id:1}])
#Statusapp.create!([{name: "Liberado"}])
#Statusapp.create!([{name: "Manutenção"}])
puts "Gerando os Users... [OK]" 
