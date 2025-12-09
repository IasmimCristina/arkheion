class CreateCharacterAttacks < ActiveRecord::Migration[8.1]
  def change
    create_table :character_attacks do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string :name
      t.string :attack_bonus
      t.string :damage
      t.string :critical
      t.string :attack_type
      t.string :range

      t.timestamps
    end
  end
end
