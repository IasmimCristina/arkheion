# frozen_string_literal: true

require "dry/monads"

module Transformers
  class SkillPointsTransformer
    extend Dry::Monads[:result]

    SKILL_POINTS_PER_LEVEL = 5

    def self.call(character_sheet, processed_data)
      begin
        level = processed_data[:level] || 0
        skill_points = level * SKILL_POINTS_PER_LEVEL
        processed_data = processed_data.merge(skill_points: skill_points)
        Success([character_sheet, processed_data])
      rescue => e
        Failure("SkillPointsTransformer error: #{e.message}")
      end
    end
  end
end
