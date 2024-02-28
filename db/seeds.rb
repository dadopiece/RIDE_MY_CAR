# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Assurez-vous que Faker est requis si vous n'avez pas déjà
require 'faker'
require "open-uri"


# Nettoyage de la base de données
puts "Nettoyage de la base de données..."
User.destroy_all
Car.destroy_all
Booking.destroy_all

puts "Création de nouveaux enregistrements..."

# Configurer Faker pour utiliser la locale française
Faker::Config.locale = 'fr'

# Création de 50 utilisateurs
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    phone_number: Faker::PhoneNumber.phone_number,
    valid_driver_license: Faker::Boolean.boolean
  )
end

# Récupération des IDs des utilisateurs
user_ids = User.pluck(:id)

# Création de 70 voitures
10.times do |index|
  car = Car.create!(
    model: Faker::Vehicle.model,
    brand: Faker::Vehicle.make,
    price: Faker::Commerce.price(range: 5000..30000),
    user_id: user_ids.sample,
    address: Faker::Address.street_address + ", " + "75" + rand(001..20).to_s.rjust(3, '0') + " Paris"
  )

  # Générer une URL unique pour chaque voiture
  file = URI.open(Faker::LoremFlickr.image(size: "300x300", search_terms: ['car']) + "?random=#{car.id}")
  car.photo.attach(io: file, filename: "car_#{index + 1}.png", content_type: "image/jpg")
end

# Création de réservations
10.times do
  start_date = Faker::Date.backward(days: 14)
  end_date = start_date + rand(1..10).days

  Booking.create!(
    car_id: Car.pluck(:id).sample,
    user_id: user_ids.sample,
    start_date: start_date,
    end_date: end_date,
    status: ['confirmed', 'pending', 'cancelled'].sample
  )
end

puts "Données générées avec succès."
