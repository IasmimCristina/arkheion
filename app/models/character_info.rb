# frozen_string_literal: true

class CharacterInfo < ApplicationRecord
  belongs_to :character_sheet

  validates :character_name, presence: true
  validates :race, presence: true
  validates :origin, presence: true
  validates :character_class, presence: true
  validates :level, presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 20 }

  enum :race, {
    humano: "humano",
    anao: "anao",
    elfo: "elfo",
    dahllan: "dahllan",
    goblin: "goblin",
    hynne: "hynne",
    medusa: "medusa",
    sereia_tritao: "sereia_tritao",
    qareen: "qareen",
    suraggel: "suraggel",
    minotauro: "minotauro",
    golem: "golem",
    kliren: "kliren",
    lefou: "lefou",
    osteon: "osteon",
    silfide: "silfide",
    trog: "trog"
  }, prefix: true

  enum :character_class, {
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
  }, prefix: true

  def class_information
    ClassData.for_class(character_class)
  end

  def class_description
    class_information[:description]
  end

  def class_hit_points
    class_information[:hit_points]
  end

  def class_mana_points
    class_information[:mana_points]
  end

  def class_primary_attribute
    class_information[:primary_attribute]
  end

  def class_trained_skills
    class_information[:trained_skills]
  end

  def full_description
    "#{character_name}, #{race_humanized} #{character_class_humanized} Nível #{level}"
  end

  def basic_race?
    %w[humano anao elfo].include?(race)
  end

  def expanded_race?
    !basic_race?
  end

  private

  def race_humanized
    case race
    when "sereia_tritao"
      "Sereia/Tritão"
    else
      race&.humanize&.gsub("_", "-")
    end
  end

  def character_class_humanized
    character_class&.humanize
  end
end
