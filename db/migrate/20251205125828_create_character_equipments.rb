class CreateCharacterEquipments < ActiveRecord::Migration[8.1]
  def change
    create_table :character_equipments do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string :name
      t.decimal :weight
      t.integer :quantity
      t.boolean :equipped

      t.timestamps
    end
  end
end
