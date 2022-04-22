# frozen_string_literal: true

require 'json'

class Workflow
  def items
    @items ||= []
  end

  def print
    $stdout.print({ items: items }.to_json)
  end

  def filter!(filter)
    @items = items.select { |item| item.include?(filter) } if filter
    self
  end
end

class WorkflowItem
  attr_accessor :title, :subtitle

  def initialize(title, subtitle = nil)
    @title = title
    @subtitle = subtitle || title
  end

  def as_json(_options = {})
    argument = @title.eql?(@subtitle) ? @title : "'#{@title}' #{@subtitle}"

    {
      title: @title,
      subtitle: @subtitle,
      valid: true,
      arg: argument
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def include?(filter)
    title.include?(filter) || subtitle.include?(filter)
  end
end
