#!/usr/bin/ruby
# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'
require_relative 'workflow'

base_path = ENV.fetch('BASE_URL', nil)
sheet = ARGV[0]
filter = ARGV[1]

raise 'BASE_URL env var is required' unless base_path
raise 'sheet key is required' unless sheet

uri = URI("#{base_path}/sheets/#{sheet}/shortcuts")
res = Net::HTTP.get_response(uri)
# puts "uri-=------`#{uri}`"
# puts "res.body-=------`#{res.body}`"

result = JSON.parse(res.body)
workflow = Workflow.new

result['shortcuts'].each do |shortcut|
  workflow.items << WorkflowItem.new(
    shortcut['name'],
    shortcut['command'],
    shortcut['command']
  )
end

workflow.filter!(filter).print
