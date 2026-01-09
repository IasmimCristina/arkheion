# frozen_string_literal: true

require "dry/monads"

module Transformers
  class HitPointsTransformer
    extend Dry::Monads[:result]

    def self.call(character_sheet, processed_data)
      begin
        base_hp = character_sheet.character_combat&.hit_points_max.to_i
        delta_hp = character_sheet.temp_modifications.map { |t| t.data["delta_hp"].to_i }.sum
        final_hit_points = base_hp + delta_hp

        processed_data = processed_data.merge(
          hit_points_base: base_hp,
          hit_points_delta: delta_hp,
          hit_points_total: final_hit_points
        )

        Success([ character_sheet, processed_data ])
      rescue => e
        Failure("HitPointsTransformer error: #{e.message}")
      end
    end
  end
end
