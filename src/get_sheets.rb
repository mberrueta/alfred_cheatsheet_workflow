#!/usr/bin/ruby
# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'
require_relative 'workflow'

base_path = ENV['BASE_URL']
raise 'BASE_URL env var is required' unless base_path

uri = URI("#{base_path}/sheets")
res = Net::HTTP.get_response(uri)
result = JSON.parse(res.body)
workflow = Workflow.new

result['sheets'].each { |k| workflow.items << WorkflowItem.new(k) }

workflow.print
