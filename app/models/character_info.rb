# frozen_string_literal: true

class CharacterInfo < ApplicationRecord
  belongs_to :character_sheet

  # ==
  validates :character_name, presence: true
  validates :race, presence: true
  validates :origin, presence: true
  validates :character_class, presence: true
  validates :level, presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 20 }

  # ==
  enum race: {
    humano: "humano",
    elfo: "elfo",
    anao: "anao",
    halfling: "halfling",
    meio_elfo: "meio_elfo",
    meio_orc: "meio_orc"
  }, _prefix: true

  enum character_class: {
    arcanista: "arcanista",
    barbaro: "barbaro",
    bardo: "bardo",
    buccaneer: "buccaneer",
    cavaleiro: "cavaleiro",
    clerigo: "clerigo",
    druida: "druida",
    guerreiro: "guerreiro",
    inventor: "inventor",
    ladino: "ladino",
    lutador: "lutador",
    noble: "noble",
    paladino: "paladino",
    ranger: "ranger"
  }, _prefix: true

  # ==
  def full_description
    "#{character_name}, #{race_humanized} #{character_class_humanized} Nível #{level}"
  end

  def experience_for_next_level
    case level
    when 1 then 1000
    when 2 then 3000
    else
      level * 1000
    end
  end

  private

  def race_humanized
    race&.humanize
  end

  def character_class_humanized
    character_class&.humanize
  end
end
