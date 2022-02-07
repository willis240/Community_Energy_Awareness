class Dashboard < ApplicationRecord
  require 'rubygems'
  require 'mqtt'

  client = MQTT::Client.connect(:host =>"test.mosquitto.org/", :port => 8080)
end
