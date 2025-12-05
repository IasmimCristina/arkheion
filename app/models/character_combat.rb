# frozen_string_literal: true

class CharacterCombat < ApplicationRecord
  belongs_to :character_sheet

  # =====
  validates :hit_points_max, :hit_points_current,
            :mana_points_max, :mana_points_current, :defense,
            numericality: { greater_than_or_equal_to: 0 }

  validate :current_points_not_greater_than_max

  # =====
  def alive?
    hit_points_current > 0
  end

  def unconscious?
    hit_points_current <= 0 && hit_points_current > dying_threshold
  end

  def dying?
    hit_points_current <= dying_threshold
  end

  def heal(amount)
    self.hit_points_current = [hit_points_current + amount, hit_points_max].min
    save!
  end

  def take_damage(amount)
    self.hit_points_current = hit_points_current - amount
    save!
  end

  def spend_mana(amount)
    return false if mana_points_current < amount

    self.mana_points_current -= amount
    save!
  end

  def total_defense
    defense + armor_bonus + shield_bonus + dexterity_modifier
  end

  private

  def dying_threshold
    -constitution_modifier
  end

  def constitution_modifier
    character_sheet.character_attributes&.constitution_modifier || 0
  end

  def dexterity_modifier
    character_sheet.character_attributes&.dexterity_modifier || 0
  end

  def current_points_not_greater_than_max
    errors.add(:hit_points_current, "não pode ser maior que o máximo") if hit_points_current > hit_points_max
    errors.add(:mana_points_current, "não pode ser maior que o máximo") if mana_points_current > mana_points_max
  end
end
