# frozen_string_literal: true

require "dry/monads"
require_dependency Rails.root.join("app/utils/json_normalizer").to_s

class ApplyLevelUpInteractor
  include Dry::Monads[:result]

  def self.call(character_sheet:, data:)
    new(character_sheet, data).call
  end

  def initialize(character_sheet, data)
    @sheet = character_sheet
    @data = ::Utils::JsonNormalizer.ensure_hash(data || {})
    @data = @data.reject { |_k, v| v.to_s.strip == "" }
  end

  def call
    ActiveRecord::Base.transaction do
      level_up = @sheet.level_ups.create!(data: @data)

      delta_hp_value = @data["delta_hp"].to_i
      if delta_hp_value != 0
        apply_temp_modification(delta_hp_value, reason: "LevelUp #{level_up.id} delta_hp")
      end

      @sheet.touch

      Success(level_up)
    end
  rescue ActiveRecord::RecordInvalid => e
    msgs = if e.respond_to?(:record) && e.record.respond_to?(:errors)
             e.record.errors.full_messages.join(", ")
    else
             e.message
    end
    Failure(msgs)
  rescue => e
    Failure("Erro interno ao aplicar level up: #{e.message}")
  end

  private

  def apply_temp_modification(delta_hp, reason:)
    @sheet.temp_modifications.create!(data: { "delta_hp" => delta_hp, "reason" => reason })
  end
end
