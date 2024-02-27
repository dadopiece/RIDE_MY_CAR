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

# Dans votre fichier de seed, pour créer des images différentes pour chaque voiture
Car.find_each.with_index(1) do |car, index|
  # Utilisez l'index pour générer une image unique
  unique_image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['car'], match_all: true) + "?random=#{index}"
  car.update(image_url: unique_image_url)
end
puts "Toutes les voitures ont été mises à jour avec des URLs d'image."
