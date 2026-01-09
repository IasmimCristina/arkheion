class CreateTempModifications < ActiveRecord::Migration[8.1]
  def change
    create_table :temp_modifications do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.jsonb :data, default: {}, null: false

      t.timestamps
    end

    add_index :temp_modifications, :data, using: :gin
  end
end
