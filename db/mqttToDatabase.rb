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


db = PG.connect(ENV['DATABASE_URL'])


if db
  puts 'datastream open'
end

 battery_query = db.exec "SELECT battery FROM microgrids WHERE name= 'Kotzebue'"
 $battery_message = Integer(battery_query.values[0][0])
 wind_query = db.exec "SELECT wind FROM microgrids WHERE name= 'Kotzebue'"
 $wind_message = Integer(wind_query.values[0][0])
 solar_query = db.exec "SELECT solar FROM microgrids WHERE name= 'Kotzebue'"
 $solar_message = Integer(solar_query.values[0][0])
 diesel_query = db.exec "SELECT diesel FROM microgrids WHERE name= 'Kotzebue'"
 $diesel_message = Integer(diesel_query.values[0][0])
 total_load_query = db.exec "SELECT total_load FROM microgrids WHERE name= 'Kotzebue'"
 $total_load = Integer(total_load_query.values[0][0])
 updated_query = db.exec "SELECT updated_at FROM microgrids WHERE name= 'Kotzebue'"
 $updated = updated_query.values[0][0]

if $wind_message == nil
  $wind_message, $solar_message, $diesel_message, $battery_message = 0
end

puts $battery_message.class, $wind_message, $solar_message, $diesel_message, $updated

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
  $updated["T"] = " "
  
  db.exec "UPDATE microgrids SET (battery, wind, solar, diesel, total_load) = (%d, %d, %d, %d, %d) WHERE name = 'Kotzebue'" % [$battery_message, $wind_message, $solar_message, $diesel_message, $total_load]

  db.exec "UPDATE microgrids SET (battery_percentage, wind_percentage, solar_percentage, diesel_percentage) = (%d, %d, %d, %d) WHERE name=Kotzebue",
             [$battery_percentage, $wind_percentage, $solar_percentage, $diesel_percentage]

end

