class RenameAttributeTypeInCharacterSkills < ActiveRecord::Migration[8.1]
  def change
    rename_column :character_skills, :attribute_type, :skill_attribute
  end
end
