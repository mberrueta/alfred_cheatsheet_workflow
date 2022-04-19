#!/usr/bin/ruby

require 'uri'
require 'net/http'
require 'json'
require_relative 'workflow'
require 'json'

base_path = ENV['base_url'] || 'https://vast-eyrie-73098.herokuapp.com'
uri = URI("#{base_path}/sheets")
res = Net::HTTP.get_response(uri)
result = JSON.parse(res.body)

workflow = Workflow.new
filter = ARGV[0] || '*'
result['sheets'].each do |key|
  next unless key.include?(filter) || filter == '*'

  workflow.items << WorkflowItem.new(key)
end

workflow.print
