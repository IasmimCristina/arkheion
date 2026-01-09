# frozen_string_literal: true

if Rails.env.development?
  puts "🧹 cleaning data..."
  CharacterSheet.destroy_all
  User.destroy_all
  puts "✅ Data cleaned!"
end

puts "Users creation..."

iasmim = User.create!(
  email: "iasmim@arkheion.com",
  password: "123456",
  password_confirmation: "123456"
)

samuel = User.create!(
  email: "samuel@arkheion.com",
  password: "123456",
  password_confirmation: "123456"
)

puts "Created users: #{User.count}"

def calculate_combat_stats(level, char_class, constitution_modifier)
  base_hp = 8
  base_mp = 4
  hp_per_level = (base_hp / 4).ceil + constitution_modifier
  total_hp = base_hp + constitution_modifier + ((level - 1) * hp_per_level)
  total_mp = (base_mp * level)
  { hit_points: [total_hp, 1].max, mana_points: [total_mp, 0].max }
end

puts "Character creation initializing..."

# ELLIOT ALDERSON - Lefou Inventor (Nível 13)
elliot_sheet = CharacterSheet.create!(
  name: "Elliot Alderson",
  player_name: "Iasmim Cristina",
  user: iasmim,
  info: {
    character_name_jsonb: "Elliot Alderson",
    race_jsonb: "lefou",
    origin_jsonb: "valkaria",
    character_class_jsonb: "inventor",
    level_jsonb: 13,
    divinity_jsonb: nil
  },
  equipments: [
    { name: "Chave de fenda", quantity: 1, weight: 0.2, equipped: true },
    { name: "Capa preta", quantity: 1, weight: 1.0, equipped: true }
  ],
  spells: [],
  attacks: [
    { name: "Arco improvisado", attack_type: "ranged", attack_bonus: "+7", damage: "1d8+2", critical: "x3", range: "18m" }
  ],
  annotations: [
    {
      category: "historico",
      content: "Órfão lefou criado nas ruas sombrias de Valkaria. Perdeu os pais ainda criança e desenvolveu suas habilidades de inventor por necessidade."
    },
    {
      category: "aliados",
      content: "Darlene, Angela, grupo de aventureiros."
    }
  ]
)

elliot_sheet.create_character_attributes!(
  strength: 12,
  dexterity: 16,
  constitution: 14,
  intelligence: 20,
  wisdom: 14,
  charisma: 8
)

combat_stats = calculate_combat_stats(13, "inventor", 2)
elliot_sheet.create_character_combat!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 18,
  armor_bonus: 4,
  shield_bonus: 0
)

# DARLENE ALDERSON - Lefou Inventor (Nível 10)
darlene_sheet = CharacterSheet.create!(
  name: "Darlene Alderson",
  player_name: "Samuel",
  user: samuel,
  info: {
    character_name_jsonb: "Darlene Alderson",
    race_jsonb: "lefou",
    origin_jsonb: "valkaria",
    character_class_jsonb: "inventor",
    level_jsonb: 10,
    divinity_jsonb: "Tanna-Toh"
  },
  equipments: [
    { name: "Kit de Alquimia", quantity: 1, weight: 3.0, equipped: true },
    { name: "Roupa Social", quantity: 1, weight: 2.0, equipped: true }
  ],
  spells: [],
  attacks: [],
  annotations: [
    {
      category: "historico",
      content: "Irmã mais nova de Elliot. Especializada em alquimia e criação de itens mágicos."
    },
    {
      category: "objetivos",
      content: "Reconquistar a confiança do irmão e ajudá-lo na luta contra as forças malignas."
    }
  ]
)

darlene_sheet.create_character_attributes!(
  strength: 10,
  dexterity: 15,
  constitution: 13,
  intelligence: 18,
  wisdom: 14,
  charisma: 12
)

combat_stats = calculate_combat_stats(10, "inventor", 1)
darlene_sheet.create_character_combat!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 14,
  armor_bonus: 1,
  shield_bonus: 0
)

# ANGELA MOSS - Elfa Clériga (Nível 10)
angela_sheet = CharacterSheet.create!(
  name: "Angela Moss",
  player_name: "Iasmim",
  user: iasmim,
  info: {
    character_name_jsonb: "Angela Moss",
    race_jsonb: "elfo",
    origin_jsonb: "templo de Khalmyr",
    character_class_jsonb: "clerigo",
    level_jsonb: 10,
    divinity_jsonb: "Khalmyr"
  },
  equipments: [
    { name: "Símbolo Sagrado", quantity: 1, weight: 0.5, equipped: true },
    { name: "Martelo de Guerra", quantity: 1, weight: 3.0, equipped: true }
  ],
  spells: [
    { name: "Curar Ferimentos", level: 1, school: "abjuracao", description: "Cura 1d8+4 PV" }
  ],
  attacks: [],
  annotations: [
    {
      category: "historico",
      content: "Elfa clériga devotada a Khalmyr, deus da justiça."
    }
  ]
)

angela_sheet.create_character_attributes!(
  strength: 12,
  dexterity: 13,
  constitution: 12,
  intelligence: 16,
  wisdom: 18,
  charisma: 14
)

combat_stats = calculate_combat_stats(10, "clerigo", 1)
angela_sheet.create_character_combat!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 16,
  armor_bonus: 4,
  shield_bonus: 2
)

# FRED IAN - Humano Arcanista (Nível 10)
fred_sheet = CharacterSheet.create!(
  name: "Fred Ian",
  player_name: "Iasmim",
  user: iasmim,
  info: {
    character_name_jsonb: "Fred Ian",
    race_jsonb: "humano",
    origin_jsonb: "bibliotecas de Wynlla",
    character_class_jsonb: "arcanista",
    level_jsonb: 10,
    divinity_jsonb: "Wynlla"
  },
  equipments: [
    { name: "Cajado Arcano", quantity: 1, weight: 2.0, equipped: true },
    { name: "Grimório Pessoal", quantity: 1, weight: 1.5, equipped: true }
  ],
  spells: [
    { name: "Mísseis Mágicos", level: 1, school: "evocacao", description: "1d4+1 dano automático" }
  ],
  attacks: [],
  annotations: [
    {
      category: "historico",
      content: "Arcanista humano de família humilde, com uma irmã mais nova."
    }
  ]
)

fred_sheet.create_character_attributes!(
  strength: 10,
  dexterity: 13,
  constitution: 14,
  intelligence: 18,
  wisdom: 15,
  charisma: 12
)

combat_stats = calculate_combat_stats(10, "arcanista", 2)
fred_sheet.create_character_combat!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 12,
  armor_bonus: 0,
  shield_bonus: 0
)

puts "✅ Character creation completed!"
