class CreateCharacterSheets < ActiveRecord::Migration[8.1]
  def change
    create_table :character_sheets do |t|
      t.string :name
      t.string :player_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
