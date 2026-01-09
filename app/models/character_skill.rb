# frozen_string_literal: true

class CharacterSkill < ApplicationRecord
  belongs_to :character_sheet

  enum :skill_attribute, {
    strength: "strength",
    dexterity: "dexterity",
    constitution: "constitution",
    intelligence: "intelligence",
    wisdom: "wisdom",
    charisma: "charisma"
  }

  validates :name, presence: true
  validates :skill_attribute, presence: true
  validates :training_bonus, numericality: true
  validates :other_bonus, numericality: true

  before_save :calculate_total

  def half_level_bonus
    lvl = character_sheet.level_jsonb.presence || 1
    (lvl.to_i) / 2
  end

  def attribute_modifier
    character_sheet.character_attributes&.send("#{skill_attribute}_modifier") || 0
  end

  def training_bonus
    read_attribute(:training_bonus) || 0
  end

  def other_bonus
    read_attribute(:other_bonus) || 0
  end

  def total_bonus
    half_level_bonus + attribute_modifier + training_bonus + other_bonus
  end

  def can_use?
    !trained_only || training_bonus > 0
  end

  private

  def calculate_total
    self.total = total_bonus
  end
end
