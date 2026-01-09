class CreateLevelUps < ActiveRecord::Migration[8.1]
  def change
    create_table :level_ups do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.jsonb :data, default: {}, null: false

      t.timestamps
    end

    add_index :level_ups, :data, using: :gin
  end
end
