# frozen_string_literal: true

class CharacterSheet < ApplicationRecord
  include UserScoped

  validates :user, presence: true

  has_one :character_attributes, dependent: :destroy
  has_one :character_combat, dependent: :destroy
  has_many :character_skills, dependent: :destroy
  has_many :character_equipments, dependent: :destroy
  has_many :character_attacks, dependent: :destroy
  has_many :character_spells, dependent: :destroy
  has_many :annotations, dependent: :destroy
    has_many :level_ups, dependent: :destroy
  has_many :temp_modifications, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :player_name, presence: true

  store_accessor :info, :character_name_jsonb, :race_jsonb, :origin_jsonb, :character_class_jsonb, :level_jsonb, :divinity_jsonb

  delegate :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma,
           to: :character_attributes, allow_nil: true
  delegate :hit_points_max, :hit_points_current, :mana_points_max, :mana_points_current, :defense,
           to: :character_combat, allow_nil: true

  # Scope
  scope :with_full_data, -> {
    includes(
      :character_attributes,
      :character_combat,
      :character_skills,
      :character_equipments,
      :character_attacks,
      :character_spells,
      :annotations
    )
  }

  # JSONB getters
  def equipment_list_jsonb
    (self[:equipments] || []).dup
  end

  def spell_list_jsonb
    (self[:spells] || []).dup
  end

  def attack_list_jsonb
    (self[:attacks] || []).dup
  end

  def annotation_list_jsonb
    (self[:annotations] || []).dup
  end

  # Helpers JSONB (persisntent)
  def add_equipment_jsonb(equipment)
    new_list = equipment_list_jsonb
    new_list << equipment
    update!(equipments: new_list)
    new_list
  end

  def add_spell_jsonb(spell)
    new_list = spell_list_jsonb
    new_list << spell
    update!(spells: new_list)
    new_list
  end

  def add_attack_jsonb(attack)
    new_list = attack_list_jsonb
    new_list << attack
    update!(attacks: new_list)
    new_list
  end

  def add_annotation_jsonb(annotation)
    new_list = annotation_list_jsonb
    new_list << annotation
    update!(annotations: new_list)
    new_list
  end

  private

  def ensure_array(value)
    value || []
  end
end
