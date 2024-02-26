# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Assurez-vous d'inclure 'bcrypt' dans votre Gemfile pour utiliser `has_secure_password`
require 'faker'
require 'bcrypt'

# Effacer les données existantes
User.delete_all
Car.delete_all
Booking.delete_all

# Création de 50 utilisateurs
100.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password_digest: BCrypt::Password.create('password'),
    phone_number: Faker::PhoneNumber.phone_number,
    valid_driver_license: Faker::Boolean.boolean
  )
end

puts "100 utilisateurs créés."

# Récupération des IDs des utilisateurs
user_ids = User.pluck(:id)

# Création de 70 voitures
70.times do
  Car.create!(
    model: Faker::Vehicle.model,
    brand: Faker::Vehicle.make,
    price: Faker::Commerce.price(range: 50..500),
    user_id: user_ids.sample # Sélectionne un user_id aléatoire parmi la liste
  )

  
end

puts "70 voitures créées."

# Récupération des IDs de 50 voitures aléatoirement pour les réservations
car_ids_for_booking = Car.pluck(:id).sample(50)

# Création de réservations pour 50 voitures sélectionnées
car_ids_for_booking.each do |car_id|
  start_date = Faker::Date.backward(days: 14) # Date de début dans les 14 jours précédents
  end_date = start_date + rand(1..10).days # Date de fin entre 1 et 10 jours après la date de début

  Booking.create!(
    car_id: car_id,
    user_id: user_ids.sample, # Sélectionne un user_id aléatoire parmi la liste
    start_date: start_date,
    end_date: end_date,
    status: ['confirmed', 'pending', 'cancelled'].sample # Statut aléatoire
  )
end

puts "50 réservations créées."
