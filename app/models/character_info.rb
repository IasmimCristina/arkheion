# frozen_string_literal: true

class CharacterInfo < ApplicationRecord
  belongs_to :character_sheet

  # ===
  validates :character_name, presence: true
  validates :race, presence: true
  validates :origin, presence: true
  validates :character_class, presence: true
  validates :level, presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 20 }

  # ===
  enum race: {

    humano: "humano",
    anao: "anao",
    elfo: "elfo",
    halfling: "halfling",
    meio_elfo: "meio_elfo",
    meio_orc: "meio_orc",

    # Extras
    qareen: "qareen",
    suraggel: "suraggel",
    minotauro: "minotauro",
    golem: "golem",
    kliren: "kliren",
    lefou: "lefou",
    osteon: "osteon",
    silfide: "silfide",
    trog: "trog"
  }, _prefix: true

  # ==
  enum character_class: {
    arcanista: "arcanista",
    barbaro: "barbaro",
    bardo: "bardo",
    bucaneiro: "bucaneiro",
    cavaleiro: "cavaleiro",
    clerigo: "clerigo",
    druida: "druida",
    guerreiro: "guerreiro",
    inventor: "inventor",
    ladino: "ladino",
    lutador: "lutador",
    nobre: "nobre",
    paladino: "paladino",
    ranger: "ranger"
  }, _prefix: true

  # =
  def full_description
    "#{character_name}, #{race_humanized} #{character_class_humanized} Nível #{level}"
  end


  def basic_race?
    %w[humano anao elfo halfling meio_elfo meio_orc].include?(race)
  end


  def expanded_race?
    !basic_race?
  end

  private

  def race_humanized
    race&.humanize&.gsub("_", "-")
  end

  def character_class_humanized
    character_class&.humanize
  end
end
