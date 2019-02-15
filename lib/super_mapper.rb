# frozen_string_literal: true

require 'super_mapper/version'

class SuperMapper
  def initialize
    yield self if block_given?
  end

  ##
  # Define a new mapping schema from a source class, mapping getters to setters
  #
  # @param [Class] source_class the class that will act as the source for this mapping definition
  def define_mapping source_class, target_class, &block
    mapping_registry["#{source_class}-#{target_class}"] = block
  end

  ##
  # Maps a source object to a target object using previously registered mappings
  #
  # @param [Object] source the source object
  # @param [Object | Class] target the target object or class. If a class is given, it should have a no-args constructor since the new instance will be created calling +target.new+
  # @return [Object] the target object, or a new instance of the target class, filled with values coming from the source
  def map source, target
    return if source.nil?

    raise ArgumentError, 'target cannot be nil' if target.nil?
    
    target.is_a?(Class) ? map_object(source, target.new) : map_object(source, target)
  end

  private

  def mapping_registry
    @mapping_registry ||= {}
  end

  def map_object source, target
    mapping_proc = mapping_registry["#{source.class}-#{target.class}"]
    mapping_proc.call source, target
    target
  end

  class Error < StandardError;
  end
end
