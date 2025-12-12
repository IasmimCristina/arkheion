# frozen_string_literal: true

class CharacterSpell < ApplicationRecord
  belongs_to :character_sheet


  validates :name, presence: true
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9 }
  validates :school, presence: true


  enum :school, {
    abjuracao: "abjuracao",
    adivinhacao: "adivinhacao",
    conjuracao: "conjuracao",
    encantamento: "encantamento",
    evocacao: "evocacao",
    ilusao: "ilusao",
    necromancia: "necromancia",
    transmutacao: "transmutacao"
  }, prefix: true


  scope :by_level, ->(level) { where(level: level) }
  scope :by_school, ->(school) { where(school: school) }


  def full_description
    "#{name} (Nível #{level}, #{school_humanized})"
  end

  private

  def school_humanized
    school&.humanize
  end
end
