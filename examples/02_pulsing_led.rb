#!/usr/bin/env ruby

# Raspberry Pi - Pulsing LED experiment
# Components : 1 red LED, 1 resistor (220Ω), 1 button

require 'bundler'
Bundler.setup
Bundler.require

# Gpio board ids
LED = 11
BTN = 12

puts '-= Raspberry Pi - Pulsing LED =-'.colorize(:cyan).bold

trap 'SIGINT' do
  puts "\nBye bye ;)".colorize(:green)
  exit
end

mode = 0
RpiComponents::setup
led = RpiComponents::Led.new(LED)

RpiComponents::Button.new(BTN).wait_press do
  mode = (mode + 1) % 5
  case mode
    when 1..3
      speed = RpiComponents::Led.pulsing_speeds.keys[mode - 1]
      puts "LED pulsing at #{speed.to_s.colorize(:green)} speed"
      led.pulse speed
    when 4
      puts 'LED on'.colorize(:green)
      led.on
    else 
      puts 'LED off'.colorize(:red)
      led.off
  end
end
