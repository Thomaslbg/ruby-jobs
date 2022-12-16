require "json"
require_relative './practitioner.rb'
require_relative './communication.rb'
require_relative './calculator.rb'

PRICES_INDEX = { base: 0.10, color: 0.18, additional_pages: 0.07, express: 0.6 }

json_path = 'data.json'

file = JSON.parse(File.read(json_path))

calculator = Calculator.new(file)

calculator.generate_output
