# frozen_string_literal: true

class FileCache
  WEEK = 60 * 60 * 24 * 7

  def self.get_or_create(file_path, &block)
    if File.exist?(file_path)
      file_content = File.read(file_path)
      File.delete(file_path) if File.mtime(file_path) < Time.now - WEEK
      file_content
    else
      content = block.call
      File.write(file_path, content)
      content
    end
  end
end
