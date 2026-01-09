# frozen_string_literal: true

puts "Creating users..."
iasmim = User.find_or_create_by!(email: "iasmim@arkheion.com") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
end

samuel = User.find_or_create_by!(email: "samuel@arkheion.com") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
end

puts "Users created: #{User.count}"

def calculate_combat_stats(level, class_key, constitution)
  base_hp = case class_key
            when "inventor" then 6
            when "clerigo" then 8
            when "guerreiro", "lutador" then 10
            else 6
            end
  hit_points = base_hp * [level.to_i, 1].max + constitution
  mana_points = [level.to_i * 2, 0].max
  { hit_points: hit_points, mana_points: mana_points }
end

puts "Creating character sheets..."

# Exemplo: Elliot Alderson
elliot = iasmim.character_sheets.find_or_create_by!(name: "elliot_alderson") do |cs|
  cs.player_name = "Iasmim"
  cs.info = {
    "character_name_jsonb" => "Elliot Alderson",
    "race_jsonb" => "lefou",
    "origin_jsonb" => "valkaria",
    "character_class_jsonb" => "inventor",
    "level_jsonb" => 13,
    "divinity_jsonb" => nil
  }
  cs.equipments = []
  cs.spells = []
  cs.attacks = []
  cs.annotations = []
end

elliot.create_character_attributes!(
  strength: 12,
  dexterity: 16,
  constitution: 14,
  intelligence: 20,
  wisdom: 14,
  charisma: 8
) unless elliot.character_attributes

stats = calculate_combat_stats(elliot.level_jsonb.to_i, elliot.character_class_jsonb, elliot.character_attributes.constitution)
elliot.create_character_combat!(
  hit_points_max: stats[:hit_points],
  hit_points_current: stats[:hit_points],
  mana_points_max: stats[:mana_points],
  mana_points_current: stats[:mana_points],
  defense: 18,
  armor_bonus: 4,
  shield_bonus: 0
) unless elliot.character_combat

# Darlene Alderson (exemple
darlene = iasmim.character_sheets.find_or_create_by!(name: "darlene_alderson") do |cs|
  cs.player_name = "Iasmim"
  cs.info = {
    "character_name_jsonb" => "Darlene Alderson",
    "race_jsonb" => "lefou",
    "origin_jsonb" => "valkaria",
    "character_class_jsonb" => "inventor",
    "level_jsonb" => 10,
    "divinity_jsonb" => nil
  }
  cs.equipments = []
  cs.spells = []
  cs.attacks = []
  cs.annotations = []
end

darlene.create_character_attributes!(
  strength: 10,
  dexterity: 15,
  constitution: 13,
  intelligence: 18,
  wisdom: 14,
  charisma: 12
) unless darlene.character_attributes

stats = calculate_combat_stats(darlene.level_jsonb.to_i, darlene.character_class_jsonb, darlene.character_attributes.constitution)
darlene.create_character_combat!(
  hit_points_max: stats[:hit_points],
  hit_points_current: stats[:hit_points],
  mana_points_max: stats[:mana_points],
  mana_points_current: stats[:mana_points],
  defense: 14,
  armor_bonus: 1,
  shield_bonus: 0
) unless darlene.character_combat

# Angela (exemplo)
angela = samuel.character_sheets.find_or_create_by!(name: "angela_moss") do |cs|
  cs.player_name = "Samuel"
  cs.info = {
    "character_name_jsonb" => "Angela Moss",
    "race_jsonb" => "elfo",
    "origin_jsonb" => "aventura",
    "character_class_jsonb" => "clerigo",
    "level_jsonb" => 10,
    "divinity_jsonb" => "deus_exemplo"
  }
  cs.equipments = []
  cs.spells = []
  cs.attacks = []
  cs.annotations = []
end

angela.create_character_attributes!(
  strength: 8,
  dexterity: 12,
  constitution: 12,
  intelligence: 14,
  wisdom: 18,
  charisma: 10
) unless angela.character_attributes

stats = calculate_combat_stats(angela.level_jsonb.to_i, angela.character_class_jsonb, angela.character_attributes.constitution)
angela.create_character_combat!(
  hit_points_max: stats[:hit_points],
  hit_points_current: stats[:hit_points],
  mana_points_max: stats[:mana_points],
  mana_points_current: stats[:mana_points],
  defense: 12,
  armor_bonus: 0,
  shield_bonus: 0
) unless angela.character_combat

puts "Seeds finished."
