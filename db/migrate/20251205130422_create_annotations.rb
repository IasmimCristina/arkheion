class CreateAnnotations < ActiveRecord::Migration[8.1]
  def change
    create_table :annotations do |t|
      t.references :character_sheet, null: false, foreign_key: true
      t.string :category
      t.text :content

      t.timestamps
    end
  end
end
