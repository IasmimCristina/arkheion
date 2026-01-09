# frozen_string_literal: true

require "dry/monads"

class ApplyLevelUpInteractor
  include Dry::Monads[:result]

  def self.call(character_sheet:, data:)
    new(character_sheet, data).call
  end

  def initialize(character_sheet, data)
    @sheet = character_sheet
    @data = Utils::JsonNormalizer.ensure_hash(data || {})
  end

  def call
    ActiveRecord::Base.transaction do
      level_up = @sheet.level_ups.create!(data: @data)

      if delta_hp = @data["delta_hp"].presence
        apply_temp_modification(delta_hp.to_i, reason: "LevelUp #{level_up.id} delta_hp")
      end

      Success(level_up)
    end
  rescue ActiveRecord::RecordInvalid => e
    Failure(e.record.errors.full_messages.join(", "))
  rescue => e
    Failure("Erro interno ao aplicar level up: #{e.message}")
  end

  private

  def apply_temp_modification(delta_hp, reason:)
    @sheet.temp_modifications.create!(data: { "delta_hp" => delta_hp, "reason" => reason })
  end
end
