require 'rubygems'
require 'mqtt'
require 'sqlite3'

client = MQTT::Client.connect(
  :host => 'mqtt.lab.acep.uaf.edu',
  :port => 1883,
  :ssl => false
)

client.subscribe( '/mock-data/kea/#' )
db = SQLite3::Database.open 'development.sqlite3'
if db
  puts 'datastream open'
end

$battery_message= db.get_first_value "SELECT battery FROM microgrids WHERE name= 'Kotzebue'"
$wind_message = db.get_first_value "SELECT wind FROM microgrids WHERE name= 'Kotzebue'"
$solar_message = db.get_first_value "SELECT solar FROM microgrids WHERE name= 'Kotzebue'"
$diesel_message = db.get_first_value "SELECT diesel FROM microgrids WHERE name= 'Kotzebue'"
$total_input = db.get_first_value "SELECT total_input FROM microgrids WHERE name= 'Kotzebue'"

puts $battery_message, $wind_message, $solar_message, $diesel_message

client.get do |topic, message|
  if topic == '/mock-data/kea/battery'
    $battery_message = Integer(message.chomp('%'))
    puts Battery: $battery_message
  end
  if topic == '/mock-data/kea/wind'
    $wind_message = Integer(message.chomp(' Watts'))
    puts Wind: $wind_message
  elsif topic == '/mock-data/kea/solar'
    $solar_message = Integer(message.chomp(' Watts'))
    puts Solar: $solar_message
  elsif  topic == '/mock-data/kea/diesel'
    $diesel_message = Integer(message.chomp(' Watts'))
    puts Diesel: $diesel_message
  end

  $total_input = $wind_message + $solar_message + $diesel_message
  if $battery_message > 0
    $total_input += $battery_message
  end
  db.execute "UPDATE microgrids SET battery=?, wind=?, solar=?, diesel=?, total_load=? WHERE name=?",
             $battery_message, $wind_message, $solar_message, $diesel_message, $total_input, 'Kotzebue'
end
