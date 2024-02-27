# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Car.find_each do |car|
  # Génère une nouvelle URL d'image aléatoire pour chaque voiture
  random_image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['car'])

  # Met à jour la voiture avec l'URL d'image
  car.update(image_url: random_image_url)

  # Si vous préférez utiliser la même URL fixe pour toutes les voitures, remplacez `random_image_url` par `fixed_image_url` dans la ligne ci-dessus.
end
puts "Toutes les voitures ont été mises à jour avec des URLs d'image."
