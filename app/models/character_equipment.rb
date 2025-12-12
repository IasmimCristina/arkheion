# frozen_string_literal: true

class CharacterEquipment < ApplicationRecord
  belongs_to :character_sheet


  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }


  scope :equipped, -> { where(equipped: true) }
  scope :unequipped, -> { where(equipped: false) }


  def total_weight
    (weight || 0) * (quantity || 0)
  end

  def equip!
    update!(equipped: true)
  end

  def unequip!
    update!(equipped: false)
  end
end
