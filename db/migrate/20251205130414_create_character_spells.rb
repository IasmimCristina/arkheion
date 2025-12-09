class CreateCharacterSpells < ActiveRecord::Migration[8.1]
  def change
    create_table :character_spells do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string :name
      t.integer :level
      t.string :school
      t.text :description

      t.timestamps
    end
  end
end
