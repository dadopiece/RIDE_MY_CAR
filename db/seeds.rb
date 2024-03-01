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

# Création de 10 utilisateurs
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

# Adresses réelles à Paris
adresses_paris = [
  "48 Rue de Rivoli, 75004 Paris",
  "10 Avenue des Champs-Élysées, 75008 Paris",
  "15 Rue de Vaugirard, 75006 Paris",
  "1 Avenue Montaigne, 75008 Paris",
  "55 Rue du Faubourg Saint-Antoine, 75011 Paris",
  "128 Rue La Boétie, 75008 Paris",
  "82 Rue de Maubeuge, 75009 Paris",
  "70 Rue de Belleville, 75020 Paris",
  "33 Avenue du Général Leclerc, 75014 Paris",
  "5 Rue de l'École de Médecine, 75006 Paris",
  "3 Place des Quinconces, 33000 Bordeaux",
  "38 Place de la Bourse, 33000 Bordeaux",
  "19 Allées de Tourny, 33000 Bordeaux",
  "56 Place de la Bourse, 33000 Bordeaux",
  "81 Rue des Trois-Conils, 33000 Bordeaux",
  "23 Cours Victor Hugo, 33000 Bordeaux",
  "11 Rue Sainte-Catherine, 33000 Bordeaux",
  "84 Rue des Trois-Conils, 33000 Bordeaux",
  "22 Rue des Trois-Conils, 33000 Bordeaux",
  "77 Cours Victor Hugo, 33000 Bordeaux"
]
# Création de 20 voitures avec adresses réelles et images locales
adresses_paris.each_with_index do |adresse, index|
  break if index >= 20 # Limite à 20 voitures pour correspondre au nombre d'images disponibles

  car = Car.create!(
    model: Faker::Vehicle.model,
    brand: Faker::Vehicle.make,
    price: Faker::Commerce.price(range: 50..300),
    user_id: user_ids.sample,
    address: adresse
  )

  # Chemin vers l'image locale dans le dossier public/images
  image_path = Rails.root.join("app", "assets", "images", "Car#{index + 1}.webp")
  # image_path = Rails.root.join("RIDE_MY_CAR/app/images/Car#{index + 1}.webp")
  # puts "Chemin de l'image: #{image_path}"


  if File.exist?(image_path)
    car.photo.attach(io: File.open(image_path), filename: "Car#{index + 1}.webp", content_type: "image/webp")
  else
    puts "Image Car#{index + 1}.webp non trouvée"
  end
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
