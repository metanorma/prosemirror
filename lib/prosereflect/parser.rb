# frozen_string_literal: true

require_relative 'node'
require_relative 'text'
require_relative 'paragraph'
require_relative 'table'
require_relative 'table_row'
require_relative 'table_cell'
require_relative 'hard_break'
require_relative 'document'

module Prosereflect
  class Parser
    def self.parse(data)
      return nil unless data.is_a?(Hash)

      parse_node(data)
    end

    def self.parse_node(data)
      return nil unless data.is_a?(Hash)

      case data['type']
      when 'text'
        Text.new(data)
      when 'paragraph'
        Paragraph.new(data)
      when 'table'
        Table.new(data)
      when 'table_row'
        TableRow.new(data)
      when 'table_cell'
        TableCell.new(data)
      when 'hard_break'
        HardBreak.new(data)
      when 'doc', 'document'
        Document.new(data)
      else
        Node.new(data)
      end
    end

    def self.parse_document(data)
      raise ArgumentError, 'Input must be a hash' if data.nil?
      raise ArgumentError, 'Input must be a hash' unless data.is_a?(Hash)

      if data['content']
        Document.new(data)
      elsif data['contents'] && data['contents']['en'] && data['contents']['en']['content']
        Document.new({ 'content' => data['contents']['en']['content'] })
      else
        Document.new
      end
    end
  end
end
