# frozen_string_literal: true

require "dry/monads"

module Transformers
  class LevelCalculatorTransformer
    extend Dry::Monads[:result]

    def self.call(character_sheet, processed_data)
      begin
        base_level = (character_sheet.respond_to?(:level_jsonb) && character_sheet.level_jsonb.present?) ? character_sheet.level_jsonb.to_i : 0
        level_from_level_ups = character_sheet.level_ups.size
        level = base_level + level_from_level_ups

        processed_data = processed_data.merge(level: level)
        Success([character_sheet, processed_data])
      rescue => e
        Failure("LevelCalculatorTransformer error: #{e.message}")
      end
    end
  end
end
