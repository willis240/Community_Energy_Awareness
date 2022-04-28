require 'rubygems'
require 'mqtt'
require 'pg'
require "date"

client = MQTT::Client.connect(
  :host => 'test.mosquitto.org',
  :port => 1883,
  :ssl => false
)

client.subscribe( '/capstone/dashboard/#' )
db = PG.connect :dbname => 'app_development' 
if db
  puts 'datastream open'
end

 $battery_message= db.get_first_value "SELECT battery FROM microgrids WHERE name= 'Kotzebue'"
 $wind_message = db.get_first_value "SELECT wind FROM microgrids WHERE name= 'Kotzebue'"
 $solar_message = db.get_first_value "SELECT solar FROM microgrids WHERE name= 'Kotzebue'"
 $diesel_message = db.get_first_value "SELECT diesel FROM microgrids WHERE name= 'Kotzebue'"
 $total_load = db.get_first_value "SELECT total_load FROM microgrids WHERE name= 'Kotzebue'"
 $updated = db.get_first_value "SELECT updated_at FROM microgrids WHERE name= 'Kotzebue'"

puts $battery_message, $wind_message, $solar_message, $diesel_message, $updated

client.get do |topic, message|
  if topic == '/capstone/dashboard/battery'
    $battery_message = Integer(message.chomp('%'))
    puts Battery: $battery_message
  end
  if topic == '/capstone/dashboard/wind'
    $wind_message = Integer(message.chomp(' Watts'))
    puts Wind: $wind_message
  elsif topic == '/capstone/dashboard/solar'
    $solar_message = Integer(message.chomp(' Watts'))
    puts Solar: $solar_message
  elsif  topic == '/capstone/dashboard/diesel'
    $diesel_message = Integer(message.chomp(' Watts'))
    puts Diesel: $diesel_message
  end

  $total_load = $wind_message + $solar_message + $diesel_message + 1
  $battery_percentage, $wind_percentage, $solar_percentage, $diesel_percentage = 0
  if $battery_message > 0
    $total_load += $battery_message
    $battery_percentage = (($battery_message / $total_load.to_f) * 100).round(2)
  end

  $wind_percentage = (($wind_message / $total_load.to_f) * 100).round(2)
  $solar_percentage = (($solar_message / $total_load.to_f) * 100).round(2)
  $diesel_percentage = (($diesel_message / $total_load.to_f) * 100).round(2)

  $updated = DateTime.now.to_s

  db.execute "UPDATE microgrids SET battery=?, wind=?, solar=?, diesel=?, total_load=?, updated_at=? WHERE name=?",
             $battery_message, $wind_message, $solar_message, $diesel_message, $total_load, $updated, 'Kotzebue'

  db.execute "UPDATE microgrids SET battery_percentage=?, wind_percentage=?, solar_percentage=?, diesel_percentage=? WHERE name=?",
             $battery_percentage, $wind_percentage, $solar_percentage, $diesel_percentage, 'Kotzebue'

end

