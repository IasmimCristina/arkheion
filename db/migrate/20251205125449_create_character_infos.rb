class CreateCharacterInfos < ActiveRecord::Migration[8.1]
  def change
    create_table :character_infos do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string :character_name
      t.string :race
      t.string :origin
      t.string :character_class
      t.integer :level
      t.string :divinity

      t.timestamps
    end
  end
end
