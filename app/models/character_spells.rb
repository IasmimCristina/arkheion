# frozen_string_literal: true

class CharacterSpell < ApplicationRecord
  belongs_to :character_sheet

  # =====
  validates :name, presence: true
  validates :level, presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9 }
  validates :school, presence: true

  # ======
  enum school: {
    abjuracao: "abjuracao",
    adivinhacao: "adivinhacao",
    convocar: "convocar",
    encantamento: "encantamento",
    evocacao: "evocacao",
    ilusao: "ilusao",
    necromancia: "necromancia",
    transmutacao: "transmutacao"
  }, _prefix: true

  # =====
  scope :by_level, ->(level) { where(level: level) }
  scope :by_school, ->(school) { where(school: school) }
  scope :cantrips, -> { where(level: 0) }

  # ======
  def cantrip?
    level == 0
  end

  def display_name
    level_text = cantrip? ? "Truque" : "Nível #{level}"
    "#{name} (#{school.humanize} - #{level_text})"
  end

  def mana_cost
    cantrip? ? 0 : level
  end

  def can_cast?
    character_sheet.character_combat&.mana_points_current.to_i >= mana_cost
  end
end
