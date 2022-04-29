#!/usr/bin/ruby
# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'
require_relative 'file_cache'
require_relative 'workflow'

base_path = ENV.fetch('BASE_URL', nil)
sheet = ARGV[0]
filter = ARGV[1]

raise 'BASE_URL env var is required' unless base_path
raise 'sheet key is required' unless sheet

uri = URI("#{base_path}/sheets/#{sheet}/shortcuts")
sheet_file = "./assets/#{sheet}.json"

result = FileCache.get_or_create(sheet_file) do
  res = Net::HTTP.get_response(uri)
  result = JSON.parse(res.body)
  workflow = Workflow.new

  result['shortcuts'].each do |shortcut|
    workflow.items << WorkflowItem.new(
      shortcut['name'],
      shortcut['command'],
      shortcut['command']
    )
  end
  workflow
end

if result.is_a?(Workflow)
  workflow.filter!(filter).print
else
  Workflow.from_json(result).filter!(filter).print
end
