# frozen_string_literal: true

module ClassData
  CLASS_INFORMATION = {
    "arcanista" => {
      description: "Um conjurador de magias arcanas, por meio de estudo, um foco ou dom natural.",
      primary_attribute: "intelligence",
      hit_points: 8,
      mana_points: 6,
      trained_skills: [ "misticismo", "vontade" ]
    },
    "barbaro" => {
      description: "Um combatente primitivo, que usa fúria e instintos para destruir seus inimigos.",
      primary_attribute: "strength",
      hit_points: 24,
      mana_points: 3,
      trained_skills: [ "fortitude", "luta" ]
    },
    "bardo" => {
      description: "Um artista mágico, que conjura magias através de música, dança ou outra forma de arte.",
      primary_attribute: "charisma",
      hit_points: 16,
      mana_points: 4,
      trained_skills: [ "atuacao", "reflexos" ]
    },
    "bucaneiro" => {
      description: "Um combatente ágil dos mares, especialista em armas de fogo e combate naval.",
      primary_attribute: "dexterity",
      hit_points: 16,
      mana_points: 3,
      trained_skills: [ "pontaria", "reflexos" ]
    },
    "cavaleiro" => {
      description: "Um guerreiro montado, mestre em combate com montaria e armas pesadas.",
      primary_attribute: "strength",
      hit_points: 20,
      mana_points: 4,
      trained_skills: [ "cavalgar", "luta" ]
    },
    "clerigo" => {
      description: "Um conjurador divino, que recebe magias de uma divindade.",
      primary_attribute: "wisdom",
      hit_points: 16,
      mana_points: 5,
      trained_skills: [ "religiao", "vontade" ]
    },
    "druida" => {
      description: "Um conjurador primal, conectado com a natureza e seus ciclos.",
      primary_attribute: "wisdom",
      hit_points: 16,
      mana_points: 5,
      trained_skills: [ "sobrevivencia", "vontade" ]
    },
    "guerreiro" => {
      description: "Um combatente treinado, especialista no uso de armas e táticas militares.",
      primary_attribute: "strength",
      hit_points: 20,
      mana_points: 2,
      trained_skills: [ "luta", "reflexos" ]
    },
    "inventor" => {
      description: "Um criador de dispositivos tecnológicos, usando ciência e engenhosidade.",
      primary_attribute: "intelligence",
      hit_points: 12,
      mana_points: 4,
      trained_skills: [ "oficio", "misticismo" ]
    },
    "ladino" => {
      description: "Um especialista em stealth, truques e combate furtivo.",
      primary_attribute: "dexterity",
      hit_points: 12,
      mana_points: 2,
      trained_skills: [ "ladinagem", "reflexos" ]
    },
    "lutador" => {
      description: "Um combatente desarmado, mestre em artes marciais e disciplina corporal.",
      primary_attribute: "strength",
      hit_points: 16,
      mana_points: 4,
      trained_skills: [ "atletismo", "fortitude" ]
    },
    "nobre" => {
      description: "Um líder nato, com recursos, educação e influência social.",
      primary_attribute: "charisma",
      hit_points: 16,
      mana_points: 3,
      trained_skills: [ "diplomacia", "nobreza" ]
    },
    "paladino" => {
      description: "Um guerreiro sagrado, que combina habilidades marciais com poderes divinos.",
      primary_attribute: "charisma",
      hit_points: 20,
      mana_points: 4,
      trained_skills: [ "religiao", "vontade" ]
    },
    "ranger" => {
      description: "Um explorador da natureza, rastreador e protetor das fronteiras selvagens.",
      primary_attribute: "dexterity",
      hit_points: 16,
      mana_points: 4,
      trained_skills: [ "sobrevivencia", "pontaria" ]
    }
  }.freeze

  def self.for_class(class_name)
    CLASS_INFORMATION[class_name.to_s] || {}
  end
end
