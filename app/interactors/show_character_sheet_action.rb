# frozen_string_literal: true

require "dry/monads"

class ShowCharacterSheetAction
  extend Dry::Monads[:result]

  def self.call(character_sheet_id)
    begin
      sheet = CharacterSheet.includes(:level_ups, :temp_modifications, :character_combat).find(character_sheet_id)

      processed_data = {}

      transformers = [
        Transformers::LevelCalculatorTransformer,
        Transformers::SkillPointsTransformer,
        Transformers::HitPointsTransformer
      ]

      result = transformers.reduce(Success([ sheet, processed_data ])) do |acc, transformer|
        if acc.failure?
          acc
        else
          s, data = acc.value!
          transformer.call(s, data)
        end
      end

      if result.failure?
        raise result.failure
      end

      processed = result.value!.last

      Success(processed)
    rescue ActiveRecord::RecordNotFound
      Failure("Ficha não encontrada")
    rescue => e
      Failure("Erro ao processar ficha: #{e.message}")
    end
  end
end
