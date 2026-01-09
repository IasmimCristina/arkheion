# frozen_string_literal: true

module Utils
  module JsonNormalizer
    module_function


    def ensure_hash(value)
      case value
      when Hash then value.deep_stringify_keys
      when ActionController::Parameters then value.to_unsafe_h.deep_stringify_keys
      else
        {}
      end
    end
  end
end
