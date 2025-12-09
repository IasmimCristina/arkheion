class CreateCharacterAttributes < ActiveRecord::Migration[8.1]
  def change
    create_table :character_attributes do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma

      t.timestamps
    end
  end
end
