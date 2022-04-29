# frozen_string_literal: true

require 'json'

class Workflow
  def items
    @items ||= []
  end

  def print
    $stdout.print(to_json)
  end

  def to_json(options = {})
    { items: items }.to_json(options)
  end

  def filter!(filter)
    @items = items.select { |item| item.include?(filter) } if filter
    self
  end
end

class WorkflowItem
  attr_accessor :title, :subtitle, :argument

  def initialize(title, subtitle = nil, argument = nil)
    @argument = argument
    @title = title
    @subtitle = subtitle || title
    @argument ||= @title
  end

  def as_json(_options = {})
    {
      title: @title,
      subtitle: @subtitle,
      valid: true,
      arg: @argument
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def include?(filter)
    title.downcase.include?(filter.downcase) ||
      subtitle.downcase.include?(filter.downcase)
  end
end
