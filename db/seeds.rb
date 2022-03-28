# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
Microgrid.create(name: "Kotzebue", total_load: 580, total_input: 580,
                 frequency: 60, wind: 50, solar: 75, diesel: 455, battery: -70)
