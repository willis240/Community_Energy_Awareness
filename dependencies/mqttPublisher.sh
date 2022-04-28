#!/usr/bin/env bash

# Written for UAF Spring 2022 CS 472 Capstone: ACEP Dashboard
# 2022.4.26

# MQTT publish to broker
# Broker is Mosquitto testing site, unencrypted, unsecured
# Battery range -79 < x < 20
# Wind, Diesel, Solar range 1 < x < 1000
# Sleep range 30s < x < 130s

echo "MQTT Transmitting"
while true
do
	echo "starting write loop"
	mosquitto_pub -h 'test.mosquitto.org' -m $(( $RANDOM % 100 - 80 )) -t /capstone/dashboard/battery 
	mosquitto_pub -h 'test.mosquitto.org' -m $(( $RANDOM % 1000 + 1 )) -t /capstone/dashboard/wind
	mosquitto_pub -h 'test.mosquitto.org' -m $(( $RANDOM % 1000 + 1 )) -t /capstone/dashboard/diesel
	mosquitto_pub -h 'test.mosquitto.org' -m $(( $RANDOM % 1000 + 1 )) -t /capstone/dashboard/solar
	echo "message sent sleeping for random time (30s < x < 130s)"
	sleep $(( $RANDOM % 100 + 30 ))
done

