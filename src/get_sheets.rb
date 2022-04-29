#!/usr/bin/ruby
# frozen_string_literal: true

require 'date'
require 'json'
require 'net/http'
require 'uri'
require_relative 'file_cache'
require_relative 'workflow'

SHEET_FILE = './assets/sheets.json'

result = FileCache.get_or_create(SHEET_FILE) do
  base_path = ENV.fetch('BASE_URL', nil)
  raise 'BASE_URL env var is required' unless base_path

  uri = URI("#{base_path}/sheets")
  res = Net::HTTP.get_response(uri)
  result = JSON.parse(res.body)
  workflow = Workflow.new

  result['sheets'].each { |k| workflow.items << WorkflowItem.new(k) }

  workflow.to_json
end

print result
