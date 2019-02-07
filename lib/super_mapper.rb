# frozen_string_literal: true

require 'super_mapper/version'
require 'super_mapper/mapping'

class SuperMapper
  def define_mapping source_class
    mapping = Mapping.new
    yield mapping
    mapping_registry[source_class] = mapping
  end

  def map source, target
    target.is_a?(Class) ? map_object(source, target.new) : map_object(source, target)
  end

  private

  def mapping_registry
    @mapping_registry ||= {}
  end

  def map_object source, target
    mapping = mapping_registry[source.class]
    target.tap do |t|
      mapping.each do |key, value|
        t.send("#{key}=", source.send(value))
      end
    end
  end

  class Error < StandardError; end
end
