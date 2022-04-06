# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
Microgrid.create(name: "Kotzebue", total_load: 0, wind: 0, wind_percentage: 0.0, solar: 0, solar_percentage: 0.0,
                 diesel: 0, diesel_percentage: 0.0, battery: 0, battery_percentage: 0.0)
