class AddInfoAndDynamicListsToCharacterSheets < ActiveRecord::Migration[8.1]
  def change
    add_column :character_sheets, :info, :jsonb, default: {}, null: false
    add_column :character_sheets, :equipments, :jsonb, default: [], null: false
    add_column :character_sheets, :spells, :jsonb, default: [], null: false
    add_column :character_sheets, :attacks, :jsonb, default: [], null: false
    add_column :character_sheets, :annotations, :jsonb, default: [], null: false

    add_index :character_sheets, :info, using: :gin
    add_index :character_sheets, :equipments, using: :gin
    add_index :character_sheets, :spells, using: :gin
    add_index :character_sheets, :attacks, using: :gin
    add_index :character_sheets, :annotations, using: :gin
  end
end
