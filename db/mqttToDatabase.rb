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

client.get do |topic, message|
  puts topic
  if topic == '/mock-data/kea/battery'
    battery_message = Integer(message.chomp('%'))
    db.execute "UPDATE microgrids SET battery=?", battery_message
    puts battery_message
  end
  if topic == '/mock-data/kea/wind'
    wind_message = Integer(message.chomp(' Watts'))
    db.execute "UPDATE microgrids SET wind=?", wind_message
    puts wind_message
  elsif topic == '/mock-data/kea/solar'
    solar_message = Integer(message.chomp(' Watts'))
    db.execute "UPDATE microgrids SET solar=?", solar_message
    puts solar_message
  elsif  topic == '/mock-data/kea/diesel'
    diesel_message = Integer(message.chomp(' Watts'))
    db.execute "UPDATE microgrids SET diesel=?", diesel_message
    puts diesel_message
  end
end
