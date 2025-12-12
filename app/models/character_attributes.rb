# frozen_string_literal: true

class CharacterAttributes < ApplicationRecord
  belongs_to :character_sheet


  validates :strength, :dexterity, :constitution,
            :intelligence, :wisdom, :charisma,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 30
            }


  ATTRIBUTES = %w[strength dexterity constitution intelligence wisdom charisma].freeze

  ATTRIBUTES.each do |attr|
    define_method "#{attr}_modifier" do
      calculate_modifier(send(attr))
    end
  end


  def max_load
    strength * 3
  end

  def max_lift
    strength * 10
  end

  def initiative_bonus
    dexterity_modifier
  end

  private

  def calculate_modifier(attribute_value)
    (attribute_value - 10) / 2
  end
end
