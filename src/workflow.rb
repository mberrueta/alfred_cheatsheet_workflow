# frozen_string_literal: true

require 'json'

class Workflow
  def items
    @items ||= []
  end

  def print
    puts({ items: filtered_list }.to_json)
  end

  def filtered_list
    query = ARGV[0] || '*'

    items.select { |item| item.include?(query) || query == '*' }
  end
end

class WorkflowItem
  attr_accessor :subtitle, :title

  def initialize(title, subtitle: nil)
    @title = title
    @subtitle = subtitle || title
  end

  def as_json(_options = {})
    {
      subtitle: @subtitle,
      title: @title
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def include?(filter)
    title.include?(filter) || subtitle.include?(filter)
  end
end
