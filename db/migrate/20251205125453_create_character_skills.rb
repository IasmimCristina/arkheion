class CreateCharacterSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :character_skills do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string :name
      t.string :attribute_type
      t.boolean :trained_only
      t.integer :training_bonus
      t.integer :other_bonus
      t.integer :total

      t.timestamps
    end
  end
end
