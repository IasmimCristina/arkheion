# frozen_string_literal: true

class CharacterSheet < ApplicationRecord
  include UserScoped

  validates :user, presence: true


  has_one :character_info, dependent: :destroy
  has_one :character_attributes, dependent: :destroy
  has_one :character_combat, dependent: :destroy
  has_many :character_skills, dependent: :destroy
  has_many :character_equipments, dependent: :destroy
  has_many :character_attacks, dependent: :destroy
  has_many :character_spells, dependent: :destroy


  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :player_name, presence: true


  delegate :character_name, :race, :origin, :character_class, :level, :divinity,
           to: :character_info, allow_nil: true
  delegate :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma,
           to: :character_attributes, allow_nil: true
  delegate :hit_points_max, :hit_points_current, :mana_points_max, :mana_points_current, :defense,
           to: :character_combat, allow_nil: true


  store_accessor :info, :character_name_jsonb, :race_jsonb, :origin_jsonb, :character_class_jsonb, :level_jsonb, :divinity_jsonb


  def equipment_list_jsonb
    equipments_jsonb || []
  end

  def spell_list_jsonb
    spells_jsonb || []
  end

  def attack_list_jsonb
    attacks_jsonb || []
  end

  def annotation_list_jsonb
    annotations_jsonb || []
  end


  def add_equipment_jsonb(equipment)
    self.equipments_jsonb = equipment_list_jsonb.push(equipment)
  end

  def add_spell_jsonb(spell)
    self.spells_jsonb = spell_list_jsonb.push(spell)
  end

  def add_attack_jsonb(attack)
    self.attacks_jsonb = attack_list_jsonb.push(attack)
  end

  def add_annotation_jsonb(annotation)
    self.annotations_jsonb = annotation_list_jsonb.push(annotation)
  end


  validate :info_jsonb_fields_presence

  def info_jsonb_fields_presence
    %w[character_name_jsonb race_jsonb origin_jsonb character_class_jsonb level_jsonb].each do |field|
      errors.add(field, "não pode ser vazio") if send(field).blank?
    end
  end
  # -- ---

  after_create :create_associated_records

  scope :by_class, ->(char_class) { joins(:character_info).where(character_infos: { character_class: char_class }) }
  scope :by_level_range, ->(min, max) { joins(:character_info).where(character_infos: { level: min..max }) }

  private

  def create_associated_records
    create_character_info!(
      character_name: "Novo Personagem",
      race: "humano",
      origin: "A definir",
      character_class: "guerreiro",
      level: 1
    ) unless character_info

    create_character_attributes!(
      strength: 10, dexterity: 10, constitution: 10,
      intelligence: 10, wisdom: 10, charisma: 10
    ) unless character_attributes

    create_character_combat!(
      hit_points_max: 1, hit_points_current: 1,
      mana_points_max: 1, mana_points_current: 1,
      defense: 10, armor_bonus: 0, shield_bonus: 0
    ) unless character_combat

    build_default_skills
  end

  def build_default_skills
    return if character_skills.any?

    skills_to_create = Skills::DEFAULT_SKILLS.map do |skill_data|
      {
        character_sheet_id: id,
        name: skill_data[:name],
        skill_attribute: skill_data[:attribute],
        trained_only: skill_data[:trained_only],
        training_bonus: 0,
        other_bonus: 0,
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    CharacterSkill.insert_all(skills_to_create) if skills_to_create.any?
  end
end
