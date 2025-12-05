# frozen_string_literal: true

module Skills
  DEFAULT_SKILLS = [
    { name: "Acrobacia", attribute: "dexterity", trained_only: false },
    { name: "Adestramento", attribute: "charisma", trained_only: true },
    { name: "Atletismo", attribute: "strength", trained_only: false },
    { name: "Atuação", attribute: "charisma", trained_only: false },
    { name: "Cavalgar", attribute: "dexterity", trained_only: false },
    { name: "Conhecimento", attribute: "intelligence", trained_only: true },
    { name: "Cura", attribute: "wisdom", trained_only: false },
    { name: "Diplomacia", attribute: "charisma", trained_only: false },
    { name: "Enganação", attribute: "charisma", trained_only: false },
    { name: "Fortitude", attribute: "constitution", trained_only: false },
    { name: "Furtividade", attribute: "dexterity", trained_only: false },
    { name: "Guerra", attribute: "intelligence", trained_only: true },
    { name: "Iniciativa", attribute: "dexterity", trained_only: false },
    { name: "Intimidação", attribute: "charisma", trained_only: false },
    { name: "Intuição", attribute: "wisdom", trained_only: false },
    { name: "Investigação", attribute: "intelligence", trained_only: false },
    { name: "Jogatina", attribute: "charisma", trained_only: true },
    { name: "Ladinagem", attribute: "dexterity", trained_only: true },
    { name: "Luta", attribute: "strength", trained_only: false },
    { name: "Misticismo", attribute: "intelligence", trained_only: true },
    { name: "Nobreza", attribute: "intelligence", trained_only: true },
    { name: "Ofício", attribute: "intelligence", trained_only: true },
    { name: "Percepção", attribute: "wisdom", trained_only: false },
    { name: "Pilotagem", attribute: "dexterity", trained_only: true },
    { name: "Pontaria", attribute: "dexterity", trained_only: false },
    { name: "Reflexos", attribute: "dexterity", trained_only: false },
    { name: "Religião", attribute: "wisdom", trained_only: true },
    { name: "Sobrevivência", attribute: "wisdom", trained_only: false },
    { name: "Vontade", attribute: "wisdom", trained_only: false }
  ].freeze

  # Métodos utilitários (opcional)
  def self.find_by_name(name)
    DEFAULT_SKILLS.find { |skill| skill[:name] == name }
  end

  def self.by_attribute(attribute)
    DEFAULT_SKILLS.select { |skill| skill[:attribute] == attribute }
  end

  def self.trained_only_skills
    DEFAULT_SKILLS.select { |skill| skill[:trained_only] }
  end
end
