class CreateCharacterCombats < ActiveRecord::Migration[8.1]
  def change
    create_table :character_combats do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.integer :hit_points_max
      t.integer :hit_points_current
      t.integer :mana_points_max
      t.integer :mana_points_current
      t.integer :defense
      t.integer :armor_bonus
      t.integer :shield_bonus

      t.timestamps
    end
  end
end
