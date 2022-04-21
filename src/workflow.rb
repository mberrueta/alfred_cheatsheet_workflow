# frozen_string_literal: true

require 'json'

class Workflow
  def items
    @items ||= []
  end

  def print
    $stdout.print({ items: items}.to_json)
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
      title: @title,
      valid: true,
      arg: @title
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end
