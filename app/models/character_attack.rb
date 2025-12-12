# frozen_string_literal: true

class CharacterAttack < ApplicationRecord
  belongs_to :character_sheet


  validates :name, presence: true
  validates :attack_type, presence: true
  validates :attack_bonus, presence: true
  validates :damage, presence: true


  enum :attack_type, {
    melee: "melee",
    ranged: "ranged",
    spell: "spell"
  }, prefix: true


  def full_description
    "#{name} (#{attack_type_humanized}): +#{attack_bonus} / #{damage}"
  end

  private

  def attack_type_humanized
    attack_type&.humanize
  end
end
