# frozen_string_literal: true

class CharacterSheet < ApplicationRecord
  include UserScoped

  # =====
  has_one :character_info, dependent: :destroy
  has_one :character_attributes, dependent: :destroy
  has_one :character_combat, dependent: :destroy
  has_many :character_skills, dependent: :destroy
  has_many :character_equipments, dependent: :destroy
  has_many :character_attacks, dependent: :destroy
  has_many :character_spells, dependent: :destroy
  has_many :annotations, dependent: :destroy

  # ======
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :player_name, presence: true

  # =====
  delegate :character_name, :race, :origin, :character_class, :level, :divinity,
           to: :character_info, allow_nil: true
  delegate :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma,
           to: :character_attributes, allow_nil: true
  delegate :hit_points_max, :hit_points_current, :mana_points_max, :mana_points_current, :defense,
           to: :character_combat, allow_nil: true

  # ====
  after_create :create_associated_records

  # ====
  scope :by_class, ->(char_class) { joins(:character_info).where(character_infos: { character_class: char_class }) }
  scope :by_level_range, ->(min, max) { joins(:character_info).where(character_infos: { level: min..max }) }

  private

  def create_associated_records
    create_character_info!
    create_character_attributes!
    create_character_combat!
    build_default_skills
  end

  def build_default_skills
    Skills::DEFAULT_SKILLS.each do |skill_data|
      character_skills.create!(
        name: skill_data[:name],
        attribute_type: skill_data[:attribute],
        trained_only: skill_data[:trained_only],
        training_bonus: 0,
        other_bonus: 0
      )
    end
  end
end
