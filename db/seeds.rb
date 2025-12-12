# frozen_string_literal: true


if Rails.env.development?
  puts "🧹 cleaning data..."
  CharacterSheet.destroy_all
  User.destroy_all
  puts "✅ Data cleaned!"
end

# Criar usuários
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


def calculate_base_attributes(level, race_modifiers = {})
  # T20: 25 points

  base_points = 25
  level_increases = ((level - 1) / 4) * 2  # +2 a cadaeach 4 levels

  {
    strength: 10,
    dexterity: 10,
    constitution: 10,
    intelligence: 10,
    wisdom: 10,
    charisma: 10
  }.merge(race_modifiers)
end


def calculate_combat_stats(level, char_class, constitution_modifier)
  class_data = ClassData.for_class(char_class)

  base_hp = class_data[:hit_points] || 8
  base_mp = class_data[:mana_points] || 0


  hp_per_level = (base_hp / 4).ceil + constitution_modifier
  total_hp = base_hp + constitution_modifier + ((level - 1) * hp_per_level)


  total_mp = (base_mp * level)

  { hit_points: [ total_hp, 1 ].max, mana_points: [ total_mp, 0 ].max }
end

puts "Character creation initializing..."


# ELLIOT ALDERSON - Lefou Inventor (Nível 13)


Current.user = samuel

elliot_sheet = CharacterSheet.create!(
  name: "Elliot Alderson - O Inventor Sombrio",
  player_name: "Samuel",
  user: samuel
)


elliot_sheet.character_info.update!(
  character_name: "Elliot Alderson",
  race: "lefou",
  character_class: "inventor",
  level: 13,
  origin: "Órfão das ruas de Valkaria",
  divinity: "Nimb (Deus da Tecnologia e Invenção)"
)


elliot_sheet.character_attributes.update!(
  strength: 12,
  dexterity: 16,
  constitution: 14,
  intelligence: 20,
  wisdom: 14,
  charisma: 8
)


combat_stats = calculate_combat_stats(13, "inventor", 2) # +2 CON
elliot_sheet.character_combat.update!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 10 + 3 + 2,
  armor_bonus: 2,
  shield_bonus: 0
)


elliot_skills = elliot_sheet.character_skills
elliot_skills.find_by(name: "Ofício").update!(training_bonus: 13)
elliot_skills.find_by(name: "Misticismo").update!(training_bonus: 13)
elliot_skills.find_by(name: "Investigação").update!(training_bonus: 8)
elliot_skills.find_by(name: "Furtividade").update!(training_bonus: 5)
elliot_skills.find_by(name: "Intuição").update!(training_bonus: 4)
elliot_skills.find_by(name: "Conhecimento").update!(training_bonus: 6)


# DARLENE ALDERSON - Lefou Inventor (Nível 10)


darlene_sheet = CharacterSheet.create!(
  name: "Darlene Alderson - A Alquimista Rebelde",
  player_name: "Samuel",
  user: samuel
)

darlene_sheet.character_info.update!(
  character_name: "Darlene Alderson",
  race: "lefou",
  character_class: "inventor",
  level: 10,
  origin: "Órfã das ruas de Valkaria",
  divinity: "Tanna-Toh (Deusa da Natureza e Alquimia)"
)


darlene_sheet.character_attributes.update!(
  strength: 10,
  dexterity: 15,
  constitution: 13,
  intelligence: 18,
  wisdom: 14,
  charisma: 12
)

combat_stats = calculate_combat_stats(10, "inventor", 1) # +1 CON
darlene_sheet.character_combat.update!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 10 + 2 + 2,
  armor_bonus: 1,
  shield_bonus: 0
)


darlene_skills = darlene_sheet.character_skills
darlene_skills.find_by(name: "Ofício").update!(training_bonus: 10)
darlene_skills.find_by(name: "Misticismo").update!(training_bonus: 10)
darlene_skills.find_by(name: "Diplomacia").update!(training_bonus: 6)
darlene_skills.find_by(name: "Enganação").update!(training_bonus: 4)
darlene_skills.find_by(name: "Conhecimento").update!(training_bonus: 5)
darlene_skills.find_by(name: "Percepção").update!(training_bonus: 3)

# ANGELA MOSS - Elfa Clériga (Nível 10)


Current.user = iasmim

angela_sheet = CharacterSheet.create!(
  name: "Angela Moss - A Devota da Justiça",
  player_name: "Iasmim",
  user: iasmim
)


angela_sheet.character_info.update!(
  character_name: "Angela Moss",
  race: "elfo",
  character_class: "clerigo",
  level: 10,
  origin: "Templo de Khalmyr em Deheon",
  divinity: "Khalmyr (Deus da Justiça)"
)


angela_sheet.character_attributes.update!(
  strength: 12,
  dexterity: 13,
  constitution: 12,
  intelligence: 16,
  wisdom: 18,
  charisma: 14       
)

combat_stats = calculate_combat_stats(10, "clerigo", 1) # +1 CON
angela_sheet.character_combat.update!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 10 + 1 + 2 + 4,
  armor_bonus: 4,
  shield_bonus: 2
)


angela_skills = angela_sheet.character_skills
angela_skills.find_by(name: "Religião").update!(training_bonus: 10)
angela_skills.find_by(name: "Vontade").update!(training_bonus: 10)
angela_skills.find_by(name: "Cura").update!(training_bonus: 8)
angela_skills.find_by(name: "Diplomacia").update!(training_bonus: 6)
angela_skills.find_by(name: "Intuição").update!(training_bonus: 5)
angela_skills.find_by(name: "Conhecimento").update!(training_bonus: 4)


# FRED IAN - Humano Arcanista (Nível 10)


fred_sheet = CharacterSheet.create!(
  name: "Fred Ian - O Sábio Protetor",
  player_name: "Iasmim",
  user: iasmim
)


fred_sheet.character_info.update!(
  character_name: "Fred Ian",
  race: "humano",
  character_class: "arcanista",
  level: 10,
  origin: "Bibliotecas de Wynlla",
  divinity: "Wynlla (Deusa da Magia)"
)


fred_sheet.character_attributes.update!(
  strength: 10,
  dexterity: 13,
  constitution: 14,
  intelligence: 18,
  wisdom: 15,
  charisma: 12
)

combat_stats = calculate_combat_stats(10, "arcanista", 2)
fred_sheet.character_combat.update!(
  hit_points_max: combat_stats[:hit_points],
  hit_points_current: combat_stats[:hit_points],
  mana_points_max: combat_stats[:mana_points],
  mana_points_current: combat_stats[:mana_points],
  defense: 10 + 1 + 2, # 10 base + 1 DEX + 2 nível/2
  armor_bonus: 0,      # Apenas vestes
  shield_bonus: 0
)


fred_skills = fred_sheet.character_skills
fred_skills.find_by(name: "Misticismo").update!(training_bonus: 10)
fred_skills.find_by(name: "Vontade").update!(training_bonus: 10)
fred_skills.find_by(name: "Conhecimento").update!(training_bonus: 8)
fred_skills.find_by(name: "Investigação").update!(training_bonus: 6)
fred_skills.find_by(name: "Percepção").update!(training_bonus: 4)
fred_skills.find_by(name: "Diplomacia").update!(training_bonus: 3)



puts "Items..."


elliot_sheet.character_equipments.create!([
  { name: "Capuz Preto Icônico", weight: 0.5, quantity: 1, equipped: true },
  { name: "Kit de Ferramentas de Inventor", weight: 2.0, quantity: 1, equipped: true },
  { name: "Óculos de Proteção", weight: 0.1, quantity: 1, equipped: true },
  { name: "Armadura de Couro Reforçado", weight: 10.0, quantity: 1, equipped: true },
  { name: "Componentes Alquímicos", weight: 1.0, quantity: 5, equipped: false },
  { name: "Diário de Invenções", weight: 0.5, quantity: 1, equipped: false }
])


darlene_sheet.character_equipments.create!([
  { name: "Faixas nos Braços", weight: 0.2, quantity: 2, equipped: true },
  { name: "Kit de Alquimia Portátil", weight: 3.0, quantity: 1, equipped: true },
  { name: "Roupa Social Discreta", weight: 2.0, quantity: 1, equipped: true },
  { name: "Ingredientes Alquímicos Raros", weight: 1.5, quantity: 8, equipped: false },
  { name: "Frascos Vazios", weight: 0.1, quantity: 10, equipped: false }
])


angela_sheet.character_equipments.create!([
  { name: "Símbolo Sagrado de Khalmyr", weight: 0.5, quantity: 1, equipped: true },
  { name: "Brunea (Armadura Média)", weight: 20.0, quantity: 1, equipped: true },
  { name: "Escudo Leve", weight: 3.0, quantity: 1, equipped: true },
  { name: "Martelo de Guerra", weight: 3.0, quantity: 1, equipped: true },
  { name: "Kit de Cura", weight: 1.0, quantity: 1, equipped: true },
  { name: "Textos Sagrados", weight: 2.0, quantity: 3, equipped: false },
  { name: "Água Benta", weight: 0.5, quantity: 5, equipped: false }
])


fred_sheet.character_equipments.create!([
  { name: "Cajado Arcano", weight: 2.0, quantity: 1, equipped: true },
  { name: "Grimório Pessoal", weight: 1.5, quantity: 1, equipped: true },
  { name: "Vestes de Mago", weight: 3.0, quantity: 1, equipped: true },
  { name: "Componentes Mágicos", weight: 0.5, quantity: 20, equipped: false },
  { name: "Pergaminhos de Magias", weight: 0.1, quantity: 5, equipped: false },
  { name: "Gato Familiar (Mr. Robot)", weight: 4.0, quantity: 1, equipped: false }
])



puts "✨ Adicionando magias..."

# Magias da Angela (Clériga)
angela_sheet.character_spells.create!([
  { name: "Curar Ferimentos", level: 1, school: "abjuracao", description: "Cura 1d8+4 PV" },
  { name: "Bênção", level: 1, school: "encantamento", description: "+1 em ataques e resistências" },
  { name: "Detectar o Mal", level: 1, school: "adivinhacao", description: "Detecta presenças malignas" },
  { name: "Curar Ferimentos Graves", level: 3, school: "abjuracao", description: "Cura 3d8+6 PV" },
  { name: "Luz do Dia", level: 3, school: "evocacao", description: "Cria luz intensa que afasta trevas" },
  { name: "Remover Maldição", level: 3, school: "abjuracao", description: "Remove maldições" }
])

# Magias do Fred (Arcanista)
fred_sheet.character_spells.create!([
  { name: "Mísseis Mágicos", level: 1, school: "evocacao", description: "1d4+1 dano automático" },
  { name: "Armadura Arcana", level: 1, school: "abjuracao", description: "+4 CA por 1 hora" },
  { name: "Detectar Magia", level: 1, school: "adivinhacao", description: "Detecta auras mágicas" },
  { name: "Bola de Fogo", level: 3, school: "evocacao", description: "6d6 dano em área" },
  { name: "Voo", level: 3, school: "transmutacao", description: "Concede voo por 10 min" },
  { name: "Proteção Contra Energia", level: 3, school: "abjuracao", description: "Resistência a elementos" }
])



puts "📝 Adicionando anotações temáticas..."


elliot_sheet.annotations.create!([
  {
    category: "historico",
    content: "Órfão lefou criado nas ruas sombrias de Valkaria. Perdeu os pais ainda criança e desenvolveu suas habilidades de inventor por necessidade. Usa sempre um capuz preto para esconder suas características lefou, apenas o tirando perto de amigos próximos como Darlene e Angela."
  },
  {
    category: "aliados",
    content: "Darlene Alderson (irmã e também inventora), Angela Moss (amiga de infância clériga de Khalmyr), Fred Ian (novo melhor amigo arcanista). Grupo unido contra as forças da corrupção."
  },
  {
    category: "objetivos",
    content: "Proteger Darlene e combater a corrupção do sistema. Usar suas invenções para trazer justiça ao mundo e proteger os inocentes. Manter o grupo seguro durante as aventuras."
  },
  {
    category: "observacoes",
    content: "Extremamente quieto e introspectivo. Dificuldade social mas genialidade técnica. Reconhecido como o melhor inventor da região. Vê o mundo através de lentes analíticas."
  }
])


darlene_sheet.annotations.create!([
  {
    category: "historico",
    content: "Irmã mais nova de Elliot. Abandonou o irmão no passado quando ele mais precisava, mas retornou determinada a fazer as pazes. Especializada em alquimia e criação de itens mágicos. Usa faixas para esconder as marcas lefou nos braços."
  },
  {
    category: "aliados",
    content: "Elliot Alderson (irmão inventor), Angela Moss (grande amiga), Fred Ian (novo aliado). Recentemente perdeu Cisco, seu namorado, assassinado injustamente."
  },
  {
    category: "objetivos",
    content: "Reconquistar a confiança do irmão Elliot e ajudá-lo na luta contra as forças malignas. Vingar a morte de Cisco. Nunca mais abandonar quem ela ama."
  }
])


angela_sheet.annotations.create!([
  {
    category: "historico",
    content: "Elfa clériga devotada a Khalmyr, deus da justiça. Amiga de infância de Elliot e Darlene. Deixou para trás seu relacionamento com Ollie para seguir o chamado divino. Mãe morreu injustamente, motivando sua busca por justiça."
  },
  {
    category: "aliados",
    content: "Elliot Alderson (amigo de infância), Darlene Alderson (grande amiga), Fred Ian (novo companheiro). Tem sentimentos por Elliot mas ambos não estão prontos para relacionamento."
  },
  {
    category: "inimigos",
    content: "Ollie (ex-namorado nobre que não apoiava sua missão). Forças corruptas que causaram a morte injusta de sua mãe."
  },
  {
    category: "objetivos",
    content: "Honrar a memória da mãe buscando justiça. Apoiar Elliot em sua jornada. Navegar pelas corrupções tomando decisões difíceis mas corretas segundo Khalmyr."
  }
])


fred_sheet.annotations.create!([
  {
    category: "historico",
    content: "Arcanista humano de família humilde, com uma irmã mais nova. Conheceu Elliot em um momento de extrema solidão do inventor. Estudioso das artes arcanas, com morais firmes e aversão à violência física."
  },
  {
    category: "aliados",
    content: "Elliot Alderson (melhor amigo que salvou da solidão), Mr. Robot (gato familiar). Ainda conhecendo Angela e Darlene durante as aventuras."
  },
  {
    category: "objetivos",
    content: "Ajudar Elliot a superar seus momentos difíceis. Tornar-se um herói do qual sua família pobre se orgulhe. Acabar com os vilões usando magia ao invés de violência física."
  },
  {
    category: "roleplay",
    content: "Gentil e estudioso, prefere resolver conflitos com diplomacia e magia. Passa muito tempo estudando e compartilhando conhecimento. Tem um forte senso moral e sempre tenta fazer o que é correto."
  }
])
