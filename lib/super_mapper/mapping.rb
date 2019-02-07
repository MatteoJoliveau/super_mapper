# frozen_string_literal: true
require 'forwardable'

class SuperMapper
  class Mapping
    extend Forwardable
    def_delegator :method_registry, :each

    def respond_to_missing? _method
      true
    end

    def method_missing self_method, other_method
      method_registry[self_method.to_s.delete('=').to_sym] = other_method
      super unless respond_to_missing?(self_method)
    end

    private

    def method_registry
      @method_registry ||= {}
    end
  end
end
